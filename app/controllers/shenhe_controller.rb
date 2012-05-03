class ShenheController < ApplicationController
  layout "ferrotec"  
  
  def initialization
#    url = request.env["REQUEST_URI"]
#    case url
#    when "http://www.abc.com.cn:8080/"
#    when "/dahe/"
#    redirect_to :controller => "dahe",:action => "index"
#    when "http://www.abc.sh.cn:8080/"
#    redirect_to :controller => "shenhe",:action => "index"
#    when "/hanhong/"
#    redirect_to :controller => "hanhong",:action => "index"
#    when "http://www.wagen.cn:8080/"
#    redirect_to :controller => "wagen",:action => "index"
#    when "/aqm/"
#    redirect_to :controller => "aqm",:action => "index"
#    else
#    end
  end  

  def index
    @title = "上海申和热磁电子有限公司"
    @logo = "/images/logo2.jpg"
    $company_id = 3
    @menutype = $company_id
    
    @menu1 = Category.find(
      :all,
      :conditions => "substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'" ,
      :order => "categoryorder") 

    @menu2 = Category.find(
      :all,
      :conditions => "company_id = 3 and length(categoryid) = 6 and substring(categoryid,1,3)='002'",
      :order => "categoryorder") 
    
    @menu3 = Category.find(
      :all,
      :conditions => "company_id = 3 and length(categoryid) = 6 and substring(categoryid,1,3)='003'",
      :order => "categoryorder") 
    
    @menu4 = Category.find(
      :all,
      :conditions => "company_id = 3 and length(categoryid) = 6 and substring(categoryid,1,3)='004'",
      :order => "categoryorder")  
    
    @menu5 = Category.find(
      :all,
      :conditions => "company_id = 3 and length(categoryid) = 6 and substring(categoryid,1,3)='005'",
      :order => "categoryorder") 
        #服务专区
    @menu6 = Category.find(
      :all,:conditions => "company_id = 3 and substring(categoryid,1,3) = '006' and length(categoryid) = 6",
      :order => "categoryorder")

    #读取公司信息
    @company = Company.find(:all,:conditions => " id = 3")  

    @news =  Categorylist.find(:all,
      :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
      :conditions => "categories.categoryname = '新闻动态' and categories.company_id = 3",           
      :order => "categorylists.issuedate desc",
      :limit => 3)    
  end
  
  def index_en
    @title = "上海申和热磁电子有限公司"
    @logo = "/images/shenhe_logo.jpg"
    $company_id = 3
    @menutype = $company_id
    
    @menu1 = EnCategory.find(
      :all,
      :conditions => "substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'" ,
      :order => "categoryorder") 

    @menu2 = EnCategory.find(
      :all,
      :conditions => "company_id = 3 and length(categoryid) = 6 and substring(categoryid,1,3)='002'",
      :order => "categoryorder") 
    
    @menu3 = EnCategory.find(
      :all,
      :conditions => "company_id = 3 and length(categoryid) = 6 and substring(categoryid,1,3)='003'",
      :order => "categoryorder") 
    
    @menu4 = EnCategory.find(
      :all,
      :conditions => "company_id = 3 and length(categoryid) = 6 and substring(categoryid,1,3)='004'",
      :order => "categoryorder")  
    
    @menu5 = EnCategory.find(
      :all,
      :conditions => "company_id = 3 and length(categoryid) = 6 and substring(categoryid,1,3)='005'",
      :order => "categoryorder") 
        #服务专区
    @menu6 = EnCategory.find(
      :all,:conditions => "company_id = 3 and substring(categoryid,1,3) = '006' and length(categoryid) = 6",
      :order => "categoryorder")

    #读取公司信息
    @company = EnCompany.find(:all,:conditions => " id = 3")  
    @news  = EnCategorylist.find(:all,
        :conditions => "categoryid  like '005%' and company_id = '3' ",
        :order => "issuedate desc",
        :limit => 3) 
#    @news =  EnCategorylist.find(:all,
#      :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
#      :conditions => "en_categories.categoryname = '新闻动态' and en_categories.company_id = 3",           
#      :order => "en_categorylists.created_at",
#      :limit => 3)    
  end

end
