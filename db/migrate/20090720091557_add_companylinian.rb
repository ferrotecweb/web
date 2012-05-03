class AddCompanylinian < ActiveRecord::Migration
  def self.up
    add_column :companies, :linian, :string
    add_column :companies, :url, :string
    add_column :companies,:content,    :text
  end

  def self.down
    remove_column :companies, :linian
    remove_column :companies, :url
    remove_column :companies,:content
  end
end
