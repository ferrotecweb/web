class AddRecordlist < ActiveRecord::Migration
  def self.up
    add_column :recordlists, :tabletype, :integer
    add_column :recordlists, :company_id, :integer
  end

  def self.down
    remove_column :recordlists, :tabletype
  end
end
