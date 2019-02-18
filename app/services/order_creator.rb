class OrderCreator
  def initialize(customer_email:, items_basket: OrderItemsBuilder.new, note: nil)
    @order = Order.new(customer_email: customer_email, total: 0.0, note: note)
    @basket = items_basket
  end

  attr_accessor :order, :basket

  def call
    order.order_items << basket.items
    order.total = basket.total_price
    order.save!
    order
  end
end
