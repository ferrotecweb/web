class AddCompanypage < ActiveRecord::Migration
  def self.up
    add_column :companies, :www, :string
  end

  def self.down
    remove_column :companies, :www
  end
end
