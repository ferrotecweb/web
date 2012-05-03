class EnCompany < ActiveRecord::Base
  has_many :en_category,:foreign_key => "id"
  #has_many :en_order,:foreign_key => "id"
  file_column :summarypic
end
