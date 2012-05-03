class CreateRecordlists < ActiveRecord::Migration
  def self.up
    create_table :recordlists do |t|
      t.column :categoryid,  :string,:null => false
      t.column :userid,  :string,:null => false
      t.column :operatetype,  :integer 
      t.column :memo,  :string
      t.timestamps
    end
  end

  def self.down
    drop_table :recordlists
  end
end
