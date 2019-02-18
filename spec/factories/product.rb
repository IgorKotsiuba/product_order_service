FactoryBot.define do
  factory :product do
    category
    name { 'Ice Cream' }
    price { 1.0 }
    details { { color: 'white', weight: '100g' } }
  end
end
