class EnCategory < ActiveRecord::Base
  set_primary_key "categoryid"
  has_many :en_categorylist,:foreign_key => "categoryid"
  belongs_to :en_company,:foreign_key => "company_id"

  
  validates_presence_of     :categoryname ,  :message => "栏目名称不能为空"
  #validates_uniqueness_of   :categoryname , 
  #                              :on => :create,
  #                              :message => "栏目名称不能重复"
  #validates_length_of :summary,:in => 2..10000,:message => "栏目内容没在限定范围内"
  attr_accessor :deletesummarypic
  attr_accessor :deletesmallsummarypic
  file_column :summarypic
  file_column :picturename
  #删除图片
  def deletepic
    [filename, thumbnail_name].each do |name|
      image = "#{DIRECTORY}/#{name}"
      File.delete(image) if File.exists?(image)
    end
  end
  
  #返回一个公司信息
  def self.categroytype(categoryid,categorytype)
      find(:all,
           :conditions => "categoryid='" + categoryid + "' and company_id ='" + categorytype.to_s + "'"
           )
  end
  
  #返回一个区分子公司的类型
  def self.categroycompanyid(categoryid)
      find(:all,
           :conditions => "categoryid='" + categoryid + "'"
           )
  end
  
    #汉虹菜单
  def self.hanhongmenu(categoryid)
      find(:all,
           :conditions => "substring(categoryid,1,3)='" + categoryid + "' and length(categoryid) = 6 and company_id=4",
           :order => " categoryid"
           )
  end
end
