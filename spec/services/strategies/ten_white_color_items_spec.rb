require 'rails_helper'

RSpec.describe Strategies::TenWhiteColorItems do
  describe '#discount' do
    let(:category) { create :category, name: 'Food' }
    let(:product1) { create :product, category: category, name: 'Rice White', details: { color: 'white' }, price: 10.0 }
    let(:product2) { create :product, category: category, name: 'Rice Black', details: { color: 'black' }, price: 20.0 }
    let(:order)    { create :order }
    let!(:order_item) { create :order_item, quantity: 1, price: 20.0, order: order, product: product2 }

    subject { described_class.new }

    context 'applicable' do
      let!(:order_item1) { create :order_item, quantity: 10, price: 10.0, order: order, product: product1 }

      it 'calculate and return discount' do
        expect(subject.discount(order)).to eq 1.0
      end
    end

    context 'not applicable' do
      let!(:order_item1) { create :order_item, quantity: 9, price: 10.0, order: order, product: product1 }
      let!(:order_item2) { create :order_item, quantity: 10, price: 10.0, order: order, product: product2 }

      it 'do not apply discount' do
        expect(subject.discount(order)).to eq 0.0
      end
    end
  end
end
