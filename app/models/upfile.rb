class Upfile < ActiveRecord::Base
  validates_presence_of     :filename ,  :message => "文件名不能为空"                         
  validates_uniqueness_of   :filename , :message => "文件名不能重复"
  
    #从文件系统删除头像文件
  def self.delete(filename)
      delete_file = "#{RAILS_ROOT}/public/sharefile/#{filename}"
      File.delete(delete_file) if File.exists?(delete_file)
  end
end
