class RemoveIndexNameFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_index :products, :name
  end
end
