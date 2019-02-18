FactoryBot.define do
  factory :order do
    customer_email { 'test@example.com' }
    total { 9.99 }
    discount { 0.99 }
    note { 'Some note' }
  end
end
