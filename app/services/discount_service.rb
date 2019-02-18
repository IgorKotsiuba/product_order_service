class DiscountService
  def initialize(order, strategy)
    @order = order
    @strategy = strategy
    @total_discount = 0.0
  end

  attr_accessor :strategy, :total_discount
  attr_reader :order

  def discount
    @total_discount += @strategy.discount(order)
  end
end
