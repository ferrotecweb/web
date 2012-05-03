class AddBus < ActiveRecord::Migration
  def self.up
    add_column :companies, :bus, :string
  end

  def self.down
    remove_column :companies, :bus
  end
end
