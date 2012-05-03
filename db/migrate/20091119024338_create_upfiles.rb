class CreateUpfiles < ActiveRecord::Migration
  def self.up
    create_table :upfiles do |t|
      t.column :filename,:string
      t.column :upfile,:string
      t.timestamps
    end
  end

  def self.down
    drop_table :upfiles
  end
end
