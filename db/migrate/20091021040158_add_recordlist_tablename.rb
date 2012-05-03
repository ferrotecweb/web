class AddRecordlistTablename < ActiveRecord::Migration
  def self.up
    add_column :recordlists, :tablename, :string
  end

  def self.down
    remove_column :recordlists, :tablename
  end
end
