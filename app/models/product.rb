class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0.0 }

  scope :food_only, -> { joins(:category).where(categories: { name: 'Food' }) }
  scope :computers_and_accessories_only, -> { joins(:category).where(categories: { name: 'Computers&Accessories' }) }
  scope :of_white_color, -> { where(details: { color: 'white' }) }
end
