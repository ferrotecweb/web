class CreateEnCompanies < ActiveRecord::Migration
  def self.up
    create_table :en_companies do |t|
      t.column :companyname, :string, :null => false
      t.column :fullname, :string
      t.column :address, :string
      t.column :telephone, :string
      t.column :fax, :string
      t.column :email, :string
      t.column :zipcode, :string
      t.column :linkman, :string
      t.column :summarypic, :string
      t.column :summary, :string
      t.column :categoryid, :string
      t.column :linian, :string
      t.column :url, :string
      t.column :content,    :text
      t.column :www, :string
      t.column :bus, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :en_companies
  end
end
