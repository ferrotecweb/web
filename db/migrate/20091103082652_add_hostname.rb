class AddHostname < ActiveRecord::Migration
  def self.up
    add_column :recordlists, :host_ip, :string
    add_column :recordlists, :host_name, :string
  end

  def self.down
    remove_column :recordlists, :host_ip
    remove_column :recordlists, :host_name
  end
end
