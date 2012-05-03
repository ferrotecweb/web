class AddCompanycontent < ActiveRecord::Migration
  def self.up
    add_column :companies, :summarypic, :string
    add_column :companies, :summary, :string
  end

  def self.down
    remove_column :companies, :summarypic
    remove_column :companies, :summary
  end
end
