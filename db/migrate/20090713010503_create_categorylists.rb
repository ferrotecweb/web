class CreateCategorylists < ActiveRecord::Migration
 
  def self.up
    create_table :categorylists do |t|
      t.column :categoryid,  :string,:null => false
      t.column :title,:string
      t.column :titleorder,:integer 
      t.column :titlestyle,:string
      t.column :titleurl,:string      
      t.column :content,    :text
      t.column :contentpic,:string
      t.column :writer,:string
      t.column :keyword,:string
      t.column :attribute,:string
      t.column :summary,:string
      t.column :summarypic,:string
      t.column :downloadfile,:string
      t.timestamps
    end
  end

  def self.down
    drop_table :categorylists
  end
end
