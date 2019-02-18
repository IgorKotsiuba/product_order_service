module Strategies
  class KeyboardWithMouse
    DISCOUNT = 0.03

    def discount(order)
      return 0.0 unless applicable?(order)

      mouse_items = order.order_items.where(product_id: mouses.ids)

      keyboard_items = order.order_items.where(product_id: keyboards.ids)
      limit_count = [mouse_items.sum(:quantity), keyboard_items.sum(:quantity)].min

      ammount = if mouse_items.sum(:quantity) > keyboard_items.sum(:quantity)
                  2 * keyboard_items.limit(limit_count).map(&:total_price).sum
                else
                  2 * mouse_items.limit(limit_count).map(&:total_price).sum
                end

      ammount * DISCOUNT
    end

    private

    def applicable?(order)
      @products ||= order.products.computers_and_accessories_only

      @products.exists? && mouses.exists? && keyboards.exists?
    end

    def mouses
      @mouses ||= @products.where(name: 'Mouse')
    end

    def keyboards
      @keyboards ||= @products.where(name: 'Keyboard')
    end
  end
end
