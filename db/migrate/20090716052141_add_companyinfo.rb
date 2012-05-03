class AddCompanyinfo < ActiveRecord::Migration
  def self.up
    add_column :companies, :fullname, :string
    add_column :companies, :address, :string
    add_column :companies, :telephone, :string
    add_column :companies, :fax, :string
    add_column :companies, :email, :string
    add_column :companies, :zipcode, :string
    add_column :companies, :linkman, :string
  end

  def self.down
    remove_column :companies, :fullname
    remove_column :companies, :address
    remove_column :companies, :telephone
    remove_column :companies, :fax
    remove_column :companies, :email
    remove_column :companies, :zipcode
    remove_column :companies, :linkman
  end
end
