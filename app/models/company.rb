class Company < ActiveRecord::Base
  has_many :category,:foreign_key => "id"
  has_many :order,:foreign_key => "id"
  file_column :summarypic
end
