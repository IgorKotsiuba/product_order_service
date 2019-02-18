require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:product) }

  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than(0.0) }
  it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  it { is_expected.to validate_numericality_of(:quantity).only_integer }

  describe '#total_price' do
    let(:order_item) { create :order_item, quantity: 2, price: 15.25 }

    it { expect(order_item.total_price).to eq 30.5 }
  end
end
