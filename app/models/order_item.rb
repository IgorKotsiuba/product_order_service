class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :price, presence: true, numericality: { greater_than: 0.0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }

  def total_price
    price * quantity
  end
end
