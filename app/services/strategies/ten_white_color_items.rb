module Strategies
  class TenWhiteColorItems
    DISCOUNT = 0.01

    def discount(order)
      return 0.0 unless applicable?(order)

      ammount = @items.map(&:total_price).sum
      ammount * DISCOUNT
    end

    private

    def applicable?(order)
      @products ||= order.products.of_white_color
      @items ||= order.order_items.where(product_id: @products.ids)
      @products.exists? && @items.sum(:quantity) >= 10
    end
  end
end
