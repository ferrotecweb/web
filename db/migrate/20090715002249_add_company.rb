class AddCompany < ActiveRecord::Migration
  def self.up
    add_column :categories, :company_id, :integer, :null => false
  end

  def self.down
    remove_column :categories, :company_id
  end
end
