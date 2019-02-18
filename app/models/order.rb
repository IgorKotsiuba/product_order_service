class Order < ApplicationRecord
  VALID_EMAIL_REGEX = /[a-z\d_\-.+]+@([a-z\d\-.]+\.)+[a-z]{2,4}/.freeze

  has_many :order_items
  has_many :products, through: :order_items

  validates :customer_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :total, presence: true, numericality: { greater_than: 0.0 }
end
