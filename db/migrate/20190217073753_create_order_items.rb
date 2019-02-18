class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items, id: :uuid do |t|
      t.integer :quantity, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.references :order, type: :uuid, index: true
      t.references :product, type: :uuid, index: true

      t.timestamps
    end
  end
end
