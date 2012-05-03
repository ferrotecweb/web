class AddProductsort < ActiveRecord::Migration
  def self.up
    add_column :categories, :productsort, :string
  end

  def self.down
    remove_column :categories, :productsort
  end
end
