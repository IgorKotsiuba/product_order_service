require 'rails_helper'

RSpec.describe OrderItemsBuilder do
  let(:product) { create :product, price: 10 }

  subject { described_class.new }

  describe '#add_product' do
    context 'with quantity > 0' do
      it 'change items count' do
        expect { subject.add_product(product_id: product.id, quantity: 2) }
          .to change { subject.items.length }.from(0).to(1)
      end

      it 'initilize OrderItem object' do
        subject.add_product(product_id: product.id, quantity: 2)

        expect(subject.items.first).to be_an_instance_of(OrderItem)
      end
    end

    context 'with invalid product_id' do
      it 'raise an error' do
        expect { subject.add_product(product_id: 'invalid_ID', quantity: 2) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'with quantity <= 0' do
      it 'do not change items count' do
        expect { subject.add_product(product_id: product.id, quantity: 0) }
          .not_to change { subject.items.length }
      end
    end
  end

  describe '#remove_product' do
    let(:order_item) { create :order_item, product_id: product.id }
    before { subject.items << order_item }

    context 'with valid product_id' do
      it 'change items count' do
        expect { subject.remove_product(product_id: product.id) }
          .to change { subject.items.length }.from(1).to(0)
      end
    end

    context 'with invalid product_id' do
      it 'do not change items count' do
        expect { subject.remove_product(product_id: 'invalid_ID') }.not_to change { subject.items.length }
      end
    end
  end

  describe '#total_price' do
    let(:order_item1) { create :order_item, quantity: 1, price: 10.0 }
    let(:order_item2) { create :order_item, quantity: 2, price: 5.0 }

    it 'returns total price of Order Items' do
      subject.items << order_item1
      subject.items << order_item2

      expect(subject.total_price.to_f).to eq 20.0
    end
  end
end
