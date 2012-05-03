class AddEnIssuedate < ActiveRecord::Migration
  def self.up
    add_column :en_categorylists, :issuedate, :datetime
  end

  def self.down
    remove_column :en_categorylists, :issuedate
  end
end
