class AddOrdersLanguage < ActiveRecord::Migration
  def self.up
    add_column :contacts, :language, :string
  end

  def self.down
    remove_column :contacts, :language
  end
end
