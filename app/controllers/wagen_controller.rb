class WagenController < ApplicationController
  layout nil

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
    @title = "杭州和源精密工具有限公司"
    $company_id = 6
    #读取新闻标题
    #@news = Categorylist.find_by_sql("select * from categorylists where substring(categoryid,1,3) = '005' ORDER BY created_at desc LIMIT 3")  
    @news =  Categorylist.find(:all,
      :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
      :conditions => "categories.categoryid = '005010' and categories.company_id = 6",           
      :order => "categorylists.issuedate desc",
      :limit => 4)
    @company = Company.find(:all,:conditions => "id = 6")
    @minserverarea = Category.find(:first, :conditions => "company_id = 6 and substring(categoryid,1,3) = '006' and length(categoryid) = 6", :order => "categoryid")

  end

  def index_en
    @title = "杭州和源精密工具有限公司"
    $company_id = 6
    #读取新闻标题
    #@news = Categorylist.find_by_sql("select * from categorylists where substring(categoryid,1,3) = '005' ORDER BY created_at desc LIMIT 3")  
#    @news =  EnCategorylist.find(:all,
#      :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
#      :conditions => "en_categories.categoryid = '005010' and en_categories.company_id = 6",           
#      :order => "en_categorylists.issuedate desc",
#      :limit => 4)
    @news = EnCategorylist.find(:all,
        :conditions => "categoryid  like '005%' and company_id = '6' ",
        :order => "issuedate desc",
        :limit => 4) 
    @company = EnCompany.find(:all,:conditions => "id = 6")
    @minserverarea = EnCategory.find(:first, :conditions => "company_id = 6 and substring(categoryid,1,3) = '006' and length(categoryid) = 6", :order => "categoryid")

  end
end
