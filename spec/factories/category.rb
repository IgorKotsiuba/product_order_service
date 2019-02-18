FactoryBot.define do
  factory :category do
    sequence(:name) { |i| "Category #{i+1}" }
  end
end
