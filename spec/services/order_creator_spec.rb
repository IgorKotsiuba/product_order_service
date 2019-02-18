require 'rails_helper'

RSpec.describe OrderCreator do
  let(:email) { 'test@example.com' }
  let(:order_item) { build :order_item }
  let(:items_basket) { double :items_basket, total_price: 10, items: [order_item] }

  describe '#call' do
    context 'without items_basket' do
      it 'does not create order' do
        expect { described_class.new(customer_email: email).call }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with given items_basket' do
      subject { described_class.new(customer_email: email, items_basket: items_basket) }

      it 'create order' do
        expect { subject.call }.to change { Order.count }.from(0).to(1)

        Order.last.tap do |order|
          expect(order.total.to_f).to eq 10
          expect(order.customer_email).to eq email
        end
      end

      it 'create order items' do
        expect { subject.call }.to change { OrderItem.count }.from(0).to(1)
      end
    end
  end
end
