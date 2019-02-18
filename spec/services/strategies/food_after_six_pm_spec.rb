require 'rails_helper'

RSpec.describe Strategies::FoodAfterSixPm do
  include ActiveSupport::Testing::TimeHelpers

  describe '#discount' do
    let(:category) { create :category, name: 'Food' }
    let(:product1) { create :product, category: category, name: 'Rice White', details: { color: 'white' }, price: 10.0 }
    let(:product2) { create :product, category: category, name: 'Rice Black', details: { color: 'black' }, price: 20.0 }
    let(:order)    { create :order }
    let!(:order_item1) { create :order_item, quantity: 2, price: 10.0, order: order, product: product1 }
    let!(:order_item2) { create :order_item, quantity: 1, price: 20.0, order: order, product: product2 }

    subject { described_class.new }

    context 'from 6pm to 10 pm' do
      before { travel_to Time.zone.local(2018, 2, 18, 18, 4, 44) }
      after  { travel_back }

      it 'calculate and return discount' do
        expect(subject.discount(order)).to eq 2.0
      end
    end

    context 'before 6pm' do
      before { travel_to Time.zone.local(2018, 2, 18, 10, 0, 44) }
      after  { travel_back }

      it 'do not apply discount' do
        expect(subject.discount(order)).to eq 0.0
      end
    end
  end
end
