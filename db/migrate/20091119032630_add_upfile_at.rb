class AddUpfileAt < ActiveRecord::Migration
  def self.up
    add_column :upfiles,:upfile_at,:datetime,:default=>Time.now
  end

  def self.down
     remove_column :upfiles,:upfile_at
  end
end
