class AddTechnology < ActiveRecord::Migration
  def self.up
    add_column :categorylists,:istechnologyarticle,:boolean
  end

  def self.down
    remove_column :categorylists,:istechnologyarticle
  end
end
