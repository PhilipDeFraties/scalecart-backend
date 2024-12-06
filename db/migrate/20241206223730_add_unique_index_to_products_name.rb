class AddUniqueIndexToProductsName < ActiveRecord::Migration[7.2]
  def change
    add_index :products, :name, unique: true
  end
end
