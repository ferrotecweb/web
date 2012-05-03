class AddCompanycategoryid < ActiveRecord::Migration
  def self.up
    add_column :companies, :categoryid, :string
  end

  def self.down
    remove_column :companies, :categoryid
  end
end
