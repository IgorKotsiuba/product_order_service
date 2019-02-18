require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:order_items) }
  it { is_expected.to have_many(:products).through(:order_items) }

  it { is_expected.to validate_presence_of(:customer_email) }
  it { is_expected.to allow_values('email@example.com', 'email+1@example.ca').for(:customer_email) }
  it { is_expected.not_to allow_values('email@example', 'email@.ca').for(:customer_email) }
  it { is_expected.to validate_presence_of(:total) }
  it { is_expected.to validate_numericality_of(:total).is_greater_than(0.0) }
end
