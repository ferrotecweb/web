class AddEnCategroylistsCompanyId < ActiveRecord::Migration
  def self.up
    add_column :en_categorylists,:company_id,:string
  end

  def self.down
    remove_column :en_categorylists,:company_id
  end
end
