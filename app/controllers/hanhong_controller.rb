class HanhongController < ApplicationController
  layout :isfirstpage
  def isfirstpage
    if params[:id].blank?
      nil
    else
      if @pagetype == "cn"
        "hanhong"
      else
        "en_hanhong"
      end
    end
  end
  
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
  end
  
  def en_index
  end

=begin
  def newscenter
    if params[:id].blank?
      @category = Category.find(:all,:conditions => "categoryid = '005'")
      @nid = "005"
    else
      @nid = params[:id]
      @category = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end
    @pagetype = "cn"
    @img = "/images/hanhong/about_banner.gif"
#    redirect_to 'hanhong/news/005016'
    redirect_to :controller=>'hanhong', :action => 'news'
  end
=end
  def about
    if params[:id].blank?
      @category = Category.find(:all,:conditions => "categoryid = '001028'")
      @nid = "001028"
    else
      @nid = params[:id]
      @category = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end
    @pagetype = "cn"
    @img = "/images/hanhong/about_banner.gif"
  end
  
  def en_about
    if params[:id].blank?
      @category = EnCategory.find(:all,:conditions => "categoryid = '001025'")
      @nid = "001025"
    else
      @nid = params[:id]
      @category = EnCategory.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end
    @pagetype = "en"
    @img = "/images/hanhong/about_banner.gif"
  end

  def product
    if params[:id].blank?
      @categories =Category.paginate :page => params[:page],
            :per_page => 3,
            :conditions => "substring(categoryid,1,3) = '002' and company_id = 4 and length(categoryid) = 6",
            :order => "categoryorder"
      @nid = "002"
      @title = "产品信息"
    else
      @nid = params[:id]
      if params[:id] == "002"
        @categories =  Category.paginate :page => params[:page],
              :per_page => 3,
              :conditions => "substring(categoryid,1,3) = '002' and company_id = 4 and length(categoryid) = 6",
              :order => "categoryorder"
        @title = "产品信息"
      else
        #@category = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
        @categories =  Category.paginate :page => params[:page],
              :per_page => 3,
              :conditions => "categoryid like '" + params[:id] + "%'",
              :order => "categoryid"
        #读取标题
        if  @categories.size > 0 then
          for categoryname in @categories
            @title = categoryname.categoryname
          end
        end
      end
    end
    @pagetype = "cn"
    @img = "/images/hanhong/banner_pro.jpg"
  end
  
  def en_product
    if params[:id].blank?
      @categories =EnCategory.paginate :page => params[:page],
            :per_page => 3,
            :conditions => "substring(categoryid,1,3) = '002' and company_id = 4 and length(categoryid) = 6",
            :order => "categoryorder"
      @nid = "002"
      @title = "产品信息"
    else
      @nid = params[:id]
      if params[:id] == "002"
        @categories =  EnCategory.paginate :page => params[:page],
              :per_page => 3,
              :conditions => "substring(categoryid,1,3) = '002' and company_id = 4 and length(categoryid) = 6",
              :order => "categoryorder"
        @title = "Products"
      else
        #@category = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
        @categories =  EnCategory.paginate :page => params[:page],
              :per_page => 3,
              :conditions => "categoryid = '" + params[:id] + "'"
        #读取标题
        if  @categories.size > 0 then
          for categoryname in @categories
            @title = categoryname.categoryname
          end
        end
      end
    end
    @pagetype = "en"
    @img = "/images/hanhong/banner_pro.jpg"
  end

  def product_show
    @nid = params[:id]
    @categorydetail = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    @img = "/images/hanhong/about_banner.gif"
    @pagetype = "cn"
  end
  
  def en_product_show
    @nid = params[:id]
    @categorydetail = EnCategory.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    @img = "/images/hanhong/about_banner.gif"
    @pagetype = "en"
  end

  def market
    if params[:id].blank?
      @category = Category.find(:all,:conditions => "categoryid = '003023'")
      @nid = "003023"
    else
      @nid = params[:id]
      @category = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end

    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @img = "/images/hanhong/app_banner.gif"
    @pagetype = "cn"
  end
  
  def en_market
    if params[:id].blank?
      @category = EnCategory.find(:all,:conditions => "categoryid = '003016'")
      @nid = "003016"
    else
      @nid = params[:id]
      @category = EnCategory.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end

    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @img = "/images/hanhong/app_banner.gif"
    @pagetype = "en"
  end

  def technology
    if params[:id].blank?
      @category = Category.find(:all,:conditions => "categoryid = '004018'")
      @nid = "004018"
    else
      @nid = params[:id]
      @category = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end

    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @img = "/images/hanhong/banner_tech.jpg"
    @pagetype = "cn"
  end
  
  def en_technology
    if params[:id].blank?
      @category = EnCategory.find(:all,:conditions => "categoryid = '004008'")
      @nid = "004008"
    else
      @nid = params[:id]
      @category = EnCategory.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end

    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @img = "/images/hanhong/banner_tech.jpg"
    @pagetype = "en"
  end

  def news
    if params[:id].blank?
      @categorylist = Categorylist.paginate :page => params[:page],
            :per_page => 10,
            :conditions => "categoryid = '005016'",
            :order => "issuedate desc"
      #@categorylist = Categorylist.find(:all,:conditions => "categoryid = '005016'")
      @nid = "005016"
    else
      @nid = params[:id]
      #@categorylist = Categorylist.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
      @categorylist = Categorylist.paginate :page => params[:page],
            :per_page => 10,
            :conditions => "categoryid = '" + params[:id] + "'",
            :order => "issuedate desc"
    end
    @category = Category.find(:all,:conditions => "categoryid = '" + @nid + "'")
    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @pagetype = "cn"
    @img = "/images/hanhong/news_banner.gif"
  end
  
  def en_news
    if params[:id].blank?
      @categorylist = EnCategorylist.paginate :page => params[:page],
            :per_page => 10,
            :conditions => "categoryid = '005016'",
            :order => "issuedate desc"
      #@categorylist = Categorylist.find(:all,:conditions => "categoryid = '005016'")
      @nid = "005016"
    else
      @nid = params[:id]
      #@categorylist = Categorylist.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
      @categorylist = EnCategorylist.paginate :page => params[:page],
            :per_page => 10,
            :conditions => "categoryid = '" + params[:id] + "'",
            :order => "issuedate desc"
    end
    @category = EnCategory.find(:all,:conditions => "categoryid = '" + @nid + "'")
    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @pagetype = "en"
    @img = "/images/hanhong/news_banner.gif"
  end

  def news_show
    @categorylist = Categorylist.find(:all,:conditions => "id = '" + params[:id] + "'")
    #读取categoryid
    if  @categorylist.size > 0 then
      for categorylist in @categorylist
        @title = categorylist.title
        @nid = categorylist.categoryid
      end
    end
    @pagetype = "cn"
    @img = "/images/hanhong/news_banner.gif"
  end
  
  def en_news_show
    @categorylist = EnCategorylist.find(:all,:conditions => "id = '" + params[:id] + "'")
    #读取categoryid
    if  @categorylist.size > 0 then
      for categorylist in @categorylist
        @title = categorylist.title
        @nid = categorylist.categoryid
      end
    end
    @pagetype = "en"
    @img = "/images/hanhong/news_banner.gif"
  end

  def service
    if params[:id].blank?
      @category = Category.find(:all,:conditions => "categoryid = '006008'")
      @nid = "006008"
    else
      @nid = params[:id]
      @category = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end

    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @img = "/images/hanhong/banner_ser.jpg"
    @pagetype = "cn"
  end
  
  def en_service
    if params[:id].blank?
      @category = EnCategory.find(:all,:conditions => "categoryid = '006004'")
      @nid = "006004"
    else
      @nid = params[:id]
      @category = EnCategory.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    end

    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @img = "/images/hanhong/banner_ser.jpg"
    @pagetype = "en"
  end

  def download
    if params[:id].blank?
      @categorylist = Categorylist.paginate :page => params[:page],
            :per_page => 10,
            :conditions => "categoryid = '006009'",
            :order => "issuedate desc"
      #@categorylist = Categorylist.find(:all,:conditions => "categoryid = '005016'")
      @nid = "006009"
    else
      @nid = params[:id]
      #@categorylist = Categorylist.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
      @categorylist = Categorylist.paginate :page => params[:page],
            :per_page => 10,
            :conditions => "categoryid = '" + params[:id] + "'",
            :order => "issuedate desc"
    end
    @category = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @img = "/images/hanhong/banner_ser.jpg"
    @pagetype = "cn"
  end
  
  def en_download
    if params[:id].blank?
      @categorylist = EnCategorylist.paginate :page => params[:page],
            :per_page => 10,
            :conditions => "categoryid = '006004'",
            :order => "issuedate desc"
      #@categorylist = Categorylist.find(:all,:conditions => "categoryid = '005016'")
      @nid = "006004"
    else
      @nid = params[:id]
      #@categorylist = Categorylist.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
      @categorylist = EnCategorylist.paginate :page => params[:page],
            :per_page => 10,
            :conditions => "categoryid = '" + params[:id] + "'",
            :order => "issuedate desc"
    end
    @category = EnCategory.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end
    @img = "/images/hanhong/banner_ser.jpg"
    @pagetype = "en"
  end

  def workchance
    @nid = params[:id]
    @categorydetail = Category.find(:all,:conditions => "categoryid = '" + params[:id] + "'")
    @img = "/images/hanhong/about_banner.gif"
    @pagetype = "cn"
    companyid = 4
    @company = Company.find(:all, :conditions => "id = '" + companyid.to_s + "'") 
    @menu = params[:id]
    @gzjh  = Order.paginate :page => params[:page], :per_page => 10,:conditions => "company_id = '" + companyid.to_s + "'",:order => "created_at"

  end

end
