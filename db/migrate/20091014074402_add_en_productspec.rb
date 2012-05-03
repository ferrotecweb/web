class AddEnProductspec < ActiveRecord::Migration
  def self.up
    add_column :en_categories, :productspec, :string
  end

  def self.down
    remove_column :en_categories, :productspec
  end
end
