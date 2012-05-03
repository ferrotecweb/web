class EnCategorylist < ActiveRecord::Base
  belongs_to :en_category,:foreign_key => "categoryid"
  
  file_column :summarypic
  
    #汉虹最新公告3条记录 
  def self.hanhongnewnotice()
      find(:all,
        :conditions => "categoryid='005018'",
        :order => "issuedate desc",
        :limit => 3
           )
  end
end
