class AddSummarydetail < ActiveRecord::Migration
  def self.up
    add_column :categories, :summarydetail, :string
  end

  def self.down
    remove_column :categories, :summarydetail
  end
end
