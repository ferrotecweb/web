class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :categoryid,  :string,:null => false
      t.column :categoryname,:string
      t.column :categoryorder,:integer  
      t.column :categorytype,:integer 
      t.column :categoryurl,:string      
      t.column :content,    :text
      t.column :contentpic,:string
      t.column :url,:string
      t.column :summary,:string
      t.column :summarypic,:string
      
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
