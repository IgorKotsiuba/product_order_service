class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :customer_email, null: false
      t.decimal :total, precision: 10, scale: 2, null: false
      t.decimal :discount, precision: 10, scale: 2, null: false, default: 0.0
      t.text :note

      t.timestamps
    end
  end
end
