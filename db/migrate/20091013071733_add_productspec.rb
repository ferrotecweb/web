class AddProductspec < ActiveRecord::Migration
  def self.up
    add_column :categories, :productspec, :string
  end

  def self.down
    remove_column :categories, :productspec
  end
end
