class AddIssuedate < ActiveRecord::Migration
  def self.up
    add_column :categorylists, :issuedate, :datetime
  end

  def self.down
    remove_column :categorylists, :issuedate
  end
end
