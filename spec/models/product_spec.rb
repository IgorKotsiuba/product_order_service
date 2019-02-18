require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:order_items) }
  it { is_expected.to have_many(:orders).through(:order_items) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than(0.0) }
end
