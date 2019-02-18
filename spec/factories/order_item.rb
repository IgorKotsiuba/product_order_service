FactoryBot.define do
  factory :order_item do
    product
    order
    quantity { 1 }
    price { 1.0 }
  end
end
