class Categorylist < ActiveRecord::Base
  belongs_to :category,:foreign_key => "categoryid"
  
  file_column :summarypic
  #汉虹最新公告3条记录 
  def self.hanhongnewnotice()
      find(:all,
        :conditions => "categoryid='005016'",
        :order => "issuedate desc",
        :limit => 3
           )
  end
  
end
