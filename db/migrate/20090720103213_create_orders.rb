class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.column :depart,   :string
      t.column :poth,  :string
      t.column :num,   :integer
      t.column :info,  :text
      t.column :workadd,:string
      t.column :overdate,:datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
