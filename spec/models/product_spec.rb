require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:order_items) }
  it { is_expected.to have_many(:orders).through(:order_items) }
end
