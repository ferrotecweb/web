class AddPicturename < ActiveRecord::Migration
  def self.up
    add_column :categories, :picturename, :string
  end

  def self.down
    remove_column :categories, :picturename
  end
end
