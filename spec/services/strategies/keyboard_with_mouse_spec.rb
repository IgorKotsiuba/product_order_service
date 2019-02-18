require 'rails_helper'

RSpec.describe Strategies::KeyboardWithMouse do
  describe '#discount' do
    let(:category1) { create :category, name: 'Food' }
    let(:category2) { create :category, name: 'Computers&Accessories' }
    let(:product1) do
      create :product, category: category1, name: 'Rice White', details: { color: 'white' }, price: 10.0
    end
    let(:product2) { create :product, category: category2, name: 'Mouse', details: { color: 'black' }, price: 10.0 }
    let(:product3) { create :product, category: category2, name: 'Mouse', details: { model: 'RX3' }, price: 10.0 }
    let(:product4) { create :product, category: category2, name: 'Keyboard', details: { color: 'black' }, price: 10.0 }
    let(:order)    { create :order }

    subject { described_class.new }

    context 'applicable' do
      let!(:order_item1) { create :order_item, quantity: 1, price: 10.0, order: order, product: product1 }
      let!(:order_item2) { create :order_item, quantity: 2, price: 10.0, order: order, product: product2 }
      let!(:order_item3) { create :order_item, quantity: 2, price: 10.0, order: order, product: product3 }
      let!(:order_item4) { create :order_item, quantity: 5, price: 10.0, order: order, product: product4 }

      it 'calculate and return discount' do
        expect(subject.discount(order).to_f).to eq 2.4
      end
    end

    context 'not applicable' do
      let!(:order_item1) { create :order_item, quantity: 9, price: 10.0, order: order, product: product1 }
      let!(:order_item2) { create :order_item, quantity: 10, price: 10.0, order: order, product: product2 }

      it 'do not apply discount' do
        expect(subject.discount(order).to_f).to eq 0.0
      end
    end
  end
end
