class FerrotecController < ApplicationController
#  include ApplicationHelper
  layout "ferrotec"
  
  
  def initialization
    #url = request.env["REQUEST_URI"]
    url = request.env["HTTP_HOST"]
    case url
    when "www.ferrotec.com.cn"
    when "www.ferrotec.com.cn/dahe"
    redirect_to :controller => "dahe",:action => "index"
    when "www.ferrotec.sh.cn"
    redirect_to :controller => "shenhe",:action => "index"
    when "www.hanhong.sh.cn"
    redirect_to :controller => "hanhong",:action => "index"
    when "www.wagen.cc"
    redirect_to :controller => "wagen",:action => "index"
    when "www.aqmhz.com"
    redirect_to :controller => "aqm",:action => "index"
    else
    end
  end
  
  def index
    @title = "Ferrotec中国集团"
    @firstmenu = "集团介绍"
    $company_id = 1  
  
    @menu1 = Category.find_by_sql("
        select categories.* from categories,companies 
        where categories.categoryid = companies.categoryid and categories.company_id = companies.id 
              and companies.id <> 1 and categories.company_id <> 4
          union all
          SELECT * FROM
          (select * from categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id = 1
            order by categoryid) as A  order by categoryid,id")

    #主要产品 
    @menu2 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '002' and length(categoryid) = 6 and company_id <> 4",:order => "categoryorder")
    #市场应用
    @menu3 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id = 1",:order => "categoryorder")
    #技术专区
    @menu4 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '004' and length(categoryid) = 6",:order => "categoryorder")
    #新闻中心
    @menu5 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id = 1",:order => "categoryorder")
    #服务专区
    @menu6 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '006' and length(categoryid) = 6 and company_id <> 4",:order => "categoryorder")

  

    #读取新闻标题
    #@news = Categorylist.find_by_sql("select * from categorylists where substring(categoryid,1,3) = '005' ORDER BY created_at desc LIMIT 3")  
    @news =  Categorylist.find(:all,
      :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
      :conditions => "categories.categoryname = '新闻动态'",           
      :order => "categorylists.issuedate desc",
      :limit => 8)
    @technology  = Categorylist.find(:all,
           :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
           :conditions => "categories.categoryname= '技术中心' and categorylists.istechnologyarticle = 1 ",
           :order => "categorylists.created_at")
    @logo = "/images/index1.jpg"
  end
  
  def index_en
    @title = "Ferrotec中国集团"
    @firstmenu = "集团介绍"
    $company_id = 1
    #英文格式的数据进行重写
    #集团英文菜单 
    @menu1 = EnCategory.find_by_sql("select en_categories.* from en_categories,en_companies where en_categories.categoryid = en_companies.categoryid and en_categories.company_id = en_companies.id and en_companies.id <> 1
union all
SELECT * FROM
(select * from en_categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id = 1
order by categoryid) as A  order by categoryid,id")      
    #主要产品 
    @menu2 = EnCategory.find(:all,:conditions => "substring(categoryid,1,3) = '002' and length(categoryid) = 6",:order => "categoryorder")      
    #市场应用
    @menu3 = EnCategory.find(:all,:conditions => "substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id = 1",:order => "categoryorder")      
    #技术专区
    @menu4 = EnCategory.find(:all,:conditions => "substring(categoryid,1,3) = '004' and length(categoryid) = 6",:order => "categoryorder")      
    #新闻中心
    @menu5 = EnCategory.find(:all,:conditions => "substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id = 1",:order => "categoryorder")      
    #服务专区
    @menu6 = EnCategory.find(:all,:conditions => "substring(categoryid,1,3) = '006' and length(categoryid) = 6",:order => "categoryorder")   

    #读取新闻标题
    #@news = Categorylist.find_by_sql("select * from categorylists where substring(categoryid,1,3) = '005' ORDER BY created_at desc LIMIT 3")  
    @news =  EnCategorylist.find(:all,
      :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
      :conditions => "en_categories.categoryname = '新闻动态'",           
      :order => "en_categorylists.created_at",
      :limit => 8)
    @technology  = EnCategorylist.find(:all,
           :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
           :conditions => "en_categories.categoryname= '技术中心' and en_categorylists.istechnologyarticle = 1 ",
           :order => "en_categorylists.created_at")
    @logo = "/images/jituan_logo.jpg"
  end

end
