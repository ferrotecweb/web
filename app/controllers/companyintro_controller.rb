class CompanyintroController < ApplicationController
  include ApplicationHelper
  layout :islayout
  #判定如果登陆成功就用admin布局，否则不使用布局
  def islayout
    #$company_id = params[:company].to_i
    case $company_id 
    when 6
      "wagen"
    when 5
      "aqm"
    else
      "application"
    end
  end 

  
  def index
    #companyintro(Category,params[:id],params[:company],"ch")
    navigation_menu(Category,params[:id],params[:company],"ch",1)

  end
  def index_en
    #companyintro(EnCategory,params[:id],params[:company],"en")
    navigation_menu(EnCategory,params[:id],params[:company],"en",1)
  end
  #ferrotec全球
  def ferroteclocations
    $company_id = 1
       
    navigation_menu(Category,"007",1,"ch",1)
    @menutitle = "Ferrotec(全球)" 
    @firstmenu = "集团介绍"
    @leftmenu = Category.find(:all,:conditions => "categoryid='ABC'")
    @menuid = "007"
    @menu = "/content/ferroteclocations"
    @logo = "/images/index1.jpg"
    @imgurl = "/images/banner/ferrotecmap.jpg"
    @pagetype = "ch"
    
  end
  
    #ferrotec全球
  def ferroteclocations_en
    $company_id = 1   
    navigation_menu(EnCategory,"007",1,"en",1)
    @menutitle = "Ferrotec(Group)"
    @firstmenu = "Company"
    @leftmenu = Category.find(:all,:conditions => "categoryid='ABC'")
    @menuid = "007"
    @menu = "/content/ferroteclocations_en"
    @logo = "/images/jituan_logo.jpg"
    @imgurl = "/images/banner/ferrotecmap.jpg"
    @pagetype == "en"
    
  end
  
  #网站地图
  def ferrotecmap
    $company_id = 1
    navigation_menu(Category,"008",1,"ch",1)
    @menutitle = "网站地图"
    @firstmenu = "集团介绍"
    @leftmenu = Category.find(:all,:conditions => "categoryid='ABC'")
    @menuid = "008"
    @menu = "/content/ferrotecmap"
    @logo = "/images/index1.jpg"
    @imgurl = "/images/banner/company.jpg"
    @pagetype == "ch"
    
  end

    #网站地图
  def ferrotecmap_en
    $company_id = 1
    navigation_menu(EnCategory,"008",1,"en",1)
    @menutitle = "Sitemap"
    @firstmenu = "Company"
    @leftmenu = EnCategory.find(:all,:conditions => "categoryid='ABC'")
    @menuid = "008"
    @menu = "/content/ferrotecmap_en"
    @logo = "/images/jituan_logo.jpg"
    @imgurl = "/images/banner/company.jpg"
    @pagetype == "en"
    
  end
  
  #联系我们
  def contactus
    $company_id = 1
    navigation_menu(Category,"009",1,"ch",1)
    @menutitle = "联系我们"
    @firstmenu = "集团介绍"
    @leftmenu = Category.find(:all,:conditions => "categoryid='ABC'")
    @menuid = "009"
    @menu = "/content/contactus"
    @logo = "/images/index1.jpg"
    @imgurl = "/images/banner/contactus.jpg"
    @pagetype == "ch"
    
  end
  
    #联系我们
  def contactus_en
    $company_id = 1
    navigation_menu(EnCategory,"009",1,"en",1)
    @menutitle = "Contact us"
    @firstmenu = "Company"
    @leftmenu = EnCategory.find(:all,:conditions => "categoryid='ABC'")
    @menuid = "009"
    @menu = "/content/contactus_en"
    @logo = "/images/jituan_logo.jpg"
    @imgurl = "/images/banner/contactus.jpg"
    @pagetype == "en"
    
  end
  
  
end
