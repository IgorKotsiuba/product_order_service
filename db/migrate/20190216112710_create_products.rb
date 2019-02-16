class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false, index: { unique: true }
      t.decimal :price, precision: 10, scale: 2
      t.jsonb :details, null: false, default: '{}'
      t.references :category, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
