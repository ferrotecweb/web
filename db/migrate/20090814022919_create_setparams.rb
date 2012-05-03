class CreateSetparams < ActiveRecord::Migration
  def self.up
    create_table :setparams do |t|
      t.column :modelnumber,:string
      t.column :partnumber,:string
      t.column :shafttype,:string
      t.column :shaftdimension,:string
      t.column :shaftdimensioncondition,:string
      t.column :mountingtype,:string
      t.column :fluid,:string
      t.timestamps
    end
  end

  def self.down
    drop_table :setparams
  end
end
