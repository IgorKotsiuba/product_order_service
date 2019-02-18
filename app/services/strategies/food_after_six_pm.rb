module Strategies
  class FoodAfterSixPm
    DISCOUNT = 0.05

    def discount(order)
      return 0.0 unless applicable?(order)

      items = order.order_items.where(product_id: food_products(order).ids)
      ammount = items.map(&:total_price).sum
      ammount * DISCOUNT
    end

    private

    def applicable?(order)
      requested_after_6pm? && food_products(order).exists?
    end

    def requested_after_6pm?
      time = Time.now
      Time.parse('6:00 pm') < time && time < Time.parse('10:00 pm')
    end

    def food_products(order)
      @food_products ||= order.products.food_only
    end
  end
end
