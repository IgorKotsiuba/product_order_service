class OrderItemsBuilder
  def initialize
    @items = []
  end

  attr_accessor :items

  def add_product(product_id:, quantity:)
    return if quantity <= 0

    product = Product.find(product_id)
    items << OrderItem.new(product_id: product.id, quantity: quantity, price: product.price)
  end

  def remove_product(product_id:)
    items.delete_if { |item| item.product_id == product_id }
  end

  def total_price
    items.map(&:total_price).sum
  end
end
