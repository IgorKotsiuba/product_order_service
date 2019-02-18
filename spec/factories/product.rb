FactoryBot.define do
  factory :product do
    category
    sequence(:name) { |i| "Ice Cream #{i+1}" }
    price { 1.0 }
    details { { color: 'white', weight: '100g' } }
  end
end
