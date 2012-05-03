class CreateEnCategories < ActiveRecord::Migration
  def self.up
    create_table :en_categories do |t|
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
      t.column :company_id, :integer, :null => false
      t.column :summarydetail, :string
      t.column :productsort, :string
      t.column :picturename, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :en_categories
  end
end
