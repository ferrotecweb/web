class ContentController < ApplicationController
  include ApplicationHelper
  before_filter :agent_login_required, :only=>[:productquote]
  layout nil
  #主要产品
  def mostlyproduct

    #redirect_to :controller=>'mostlyproduct',:action => 'index',:id =>params[:id]

    @menu = params[:id]
    @mostlyproduct  = Category.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'") 
    @mostlyproductdetail = Categorylist.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'",
      :order => "created_at")

    #redirect_to :controller=>'mostlyproduct',:action => 'index',:id =>params[:id]

  end
  #主要产品英文
  def mostlyproduct_en
    @menu = params[:id]
    @mostlyproduct  = EnCategory.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'") 
    @mostlyproductdetail = EnCategorylist.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'",
      :order => "created_at") 
  end
  
  #主要产品-TE特殊
  def temostlyproduct
    @menu = params[:id]
    @mostlyproduct  = Category.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'") 
    @mostlyproductdetail = Category.find(:all,
      :conditions => "substring(categoryid,1,6) = '" + params[:id] + "' and length(categoryid) = 9",
      :order => "created_at") 
  end
  
    #主要产品-TE特殊
  def temostlyproduct_en
    @menu = params[:id]
    @mostlyproduct  = EnCategory.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'") 
    @mostlyproductdetail = EnCategory.find(:all,
      :conditions => "substring(categoryid,1,6) = '" + params[:id] + "' and length(categoryid) = 9",
      :order => "created_at") 
  end
  
  #主要产品明细
  def mostlyproductdetail
    @menu = params[:id]
    #读取主产品信息
    @mostlyproduct = Category.find(:all,:conditions => {:categoryid => params[:id]})
    #主产品大类明细
    @mostlyproductdetail = Categorylist.find(:all,:conditions => " categoryid = '" + params[:id]  + "'",:order => "created_at")

    #读取标题
    if  @mostlyproduct.size > 0 then
      for categoryname in @mostlyproduct
        @title = categoryname.categoryname
      end
    end  
  end
    
  #主要产品明细
  def mostlyproductdetail_en
    @menu = params[:id]
    #读取主产品信息
    @mostlyproduct = EnCategory.find(:all,:conditions => {:categoryid => params[:id]})
    #主产品大类明细
    @mostlyproductdetail = EnCategorylist.find(:all,:conditions => " categoryid = '" + params[:id]  + "'",:order => "created_at")

    #读取标题
    if  @mostlyproduct.size > 0 then
      for categoryname in @mostlyproduct
        @title = categoryname.categoryname
      end
    end  
  end
  
  #TE主要产品明细下层信息
  def temostlyproductdetail
    @menu = params[:id]
    #明细
    @mostlyproductdetail = Categorylist.find(:all,:conditions => " id = '" + params[:id]  + "'")

    #读取标题
    if  @mostlyproductdetail.size > 0 then
      for categoryname in @mostlyproductdetail
        @title = categoryname.title
      end
    end  
  end
  
    #TE主要产品明细下层信息
  def temostlyproductdetail_en
    @menu = params[:id]
    #明细
    @mostlyproductdetail = EnCategorylist.find(:all,:conditions => " id = '" + params[:id]  + "'")

    #读取标题
    if  @mostlyproductdetail.size > 0 then
      for categoryname in @mostlyproductdetail
        @title = categoryname.title
      end
    end  
  end
  
  #和源主要产品主页
  def wagenmostlyproduct
    @menu = params[:id]
    $company_id  = params[:company]
    @menutype = $company_id 
    @mostlyproduct  = Category.find(:all,
      :conditions => "categoryid = '" + params[:id] + "' and company_id = '" + @menutype.to_s + "'") 
    @mostlyproductdetail = Category.find(:all,
      :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6  and company_id  ='" + @menutype.to_s + "'",
      :order => "categoryorder") 
  end
  
  #和源主要产品主页 英文
  def wagenmostlyproduct_en
    @menu = params[:id]
    $company_id  = params[:company]
    @menutype = $company_id 
    @mostlyproduct  = EnCategory.find(:all,
      :conditions => "categoryid = '" + params[:id] + "' and company_id = '" + @menutype.to_s + "'") 
    @mostlyproductdetail = EnCategory.find(:all,
      :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6  and company_id  ='" + @menutype.to_s + "'",
      :order => "categoryorder") 
  end
  
  #和源主要产品明细页
  def wagenmostlyproductdetail
    @menu = params[:id]
    @lists = Category.categroycompanyid(@menu)
    if  @lists.size == 1 then
      for list in @lists
        @menutype  = list.company_id
      end
    else
      @menutype = $company_id 
    end
    @mostlyproduct = Category.find(:all,:conditions => {:categoryid => params[:id]})
    @mostlyproductdetail = Category.find(:all,
      :conditions => " substring(categoryid,1,6) = '" + params[:id]  + "' and length(categoryid) = 9  and company_id  ='" + @menutype.to_s + "'",
      :order => " categoryorder") 
    #读取标题
    if  @mostlyproduct.size > 0 then
      for categoryname in @mostlyproduct
        @title = categoryname.categoryname
      end
    end  
  end
  
  #和源主要产品明细页 英文
  def wagenmostlyproductdetail_en
    @menu = params[:id]
    @lists = Category.categroycompanyid(@menu)
    if  @lists.size == 1 then
      for list in @lists
        @menutype  = list.company_id
      end
    else
      @menutype = $company_id 
    end
    
    @mostlyproduct = EnCategory.find(:all,:conditions => {:categoryid => params[:id]})
    @mostlyproductdetail = EnCategory.find(:all,
      :conditions => " substring(categoryid,1,6) = '" + params[:id]  + "' and length(categoryid) = 9  and company_id  ='" + @menutype.to_s + "'",
      :order => "categoryorder") 
    #读取标题
    if  @mostlyproduct.size > 0 then
      for categoryname in @mostlyproduct
        @title = categoryname.categoryname
      end
    end  
  end
    
  #市场应用
  def marketapply
    @menu = params[:id]
    $company_id = params[:company]
    @lists = Category.categroycompanyid(@menu)
    if  @lists.size == 1 then
      for list in @lists
        @menutype  = list.company_id
        @title = list.categoryname
      end
    else 
      @menutype  = $company_id
      @category = Category.categroytype(@menu,@menutype)
      if  @category.size > 0 then
        for category in @category
          @title = category.categoryname
        end
      end
    end
    
    
    #读取市场应用主菜单
    @marketapply = Category.find(:all,
      :conditions => "categoryid = '" + params[:id]  + "' and company_id ='" + @menutype.to_s + "'")
    #读取市场应用子菜单
    if params[:id].length == 3
      @marketapplydetail = Category.find(:all,
        :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6  and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder") 
    else
      @marketapplydetail = Category.find(:all,
        :conditions => " substring(categoryid,1,6) = '" + params[:id]  + "' and length(categoryid) = 9 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder")
    end
  end
  
  #市场应用 英文
  def marketapply_en
    @menu = params[:id]
    $company_id = params[:company]
    @lists = EnCategory.categroycompanyid(@menu)
    if  @lists.size == 1 then
      for list in @lists
        @menutype  = list.company_id
        @title = list.categoryname
      end
    else 
      @menutype  = $company_id
      @category = EnCategory.categroytype(@menu,@menutype)
      if  @category.size > 0 then
        for category in @category
          @title = category.categoryname
        end
      end
    end
    
    
    #读取市场应用主菜单
    @marketapply = EnCategory.find(:all,
      :conditions => "categoryid = '" + params[:id]  + "' and company_id ='" + @menutype.to_s + "'")
    #读取市场应用子菜单
    if params[:id].length == 3
      @marketapplydetail = EnCategory.find(:all,
        :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6  and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder") 
    else
      @marketapplydetail = EnCategory.find(:all,
        :conditions => " substring(categoryid,1,6) = '" + params[:id]  + "' and length(categoryid) = 9 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder")
    end
  end
  
  #集团市场应用明细
  def jtmarketapplydetail
    @menu = params[:id]
       
    #读取集团市场应用明细菜单
    @marketapply = Category.find(:all,
      :conditions => "categoryid = '" + params[:id]  + "'")
    
    #读取市场应用关联公司规类菜单下的产品信息
    #@marketapplydetail = Category.find(:all,
    #  :conditions => " productsort = (select categoryid from categories where productsort ='" + params[:id]  + "')",
    #  :order => "categoryorder")
    @marketapplydetail = Category.find(:all,
      :conditions => " productsort = '" + params[:id]  + "'",
      :order => "company_id")
  end
  
  #集团市场应用明细
  def jtmarketapplydetail_en
    @menu = params[:id]
       
    #读取集团市场应用明细菜单
    @marketapply = EnCategory.find(:all,
      :conditions => "categoryid = '" + params[:id]  + "'")
    
    #读取市场应用关联公司规类菜单下的产品信息
   # @marketapplydetail = EnCategory.find(:all,
   #   :conditions => " productsort = (select categoryid from en_categories where productsort ='" + params[:id]  + "')",
   #   :order => "categoryorder")
    @marketapplydetail = EnCategory.find(:all,
      :conditions => " productsort = '" + params[:id]  + "'",
      :order => "company_id")
  end
  
  #市场应用明细
  def marketapplydetail
    @menu = params[:id]
    @category = Category.categroycompanyid(@menu)
    if  @category.size > 0 then
      for category in @category
        @menutype  = category.company_id
        @title = category.categoryname
      end
    end
    @marketapplydetail = Category.find(:all,
      :conditions => " categoryid = '" + params[:id] + "'",
      :order => "categoryorder") 
    #@marketapplydetail = Category.find(:all,
    #  :conditions => " substring(categoryid,1,3) = '002' and length(categoryid) = 6  and productsort ='" + params[:id] + "'",
    #  :order => "categoryorder") 
  end
  
  #市场应用明细 英文
  def marketapplydetail_en
    @menu = params[:id]
    @category = EnCategory.categroycompanyid(@menu)
    if  @category.size > 0 then
      for category in @category
        @menutype  = category.company_id
        @title = category.categoryname
      end
    end
    @marketapplydetail = EnCategory.find(:all,
      :conditions => " categoryid = '" + params[:id] + "'",
      :order => "categoryorder") 
  end
  
  #技术专区
  def technology
    @menu = params[:id]
    $company_id = params[:company]
    @menutype  = $company_id
    @category = Category.categroytype(@menu,@menutype)
    if  @category.size > 0 then
      for category in @category        
        @title = category.categoryname
      end
    end
    
    
    #@lists = Category.categroycompanyid(@menu)
    #if  @lists.size == 1 then
    #  for list in @lists
    #    @menutype  = list.company_id
    #    @title = list.categoryname
    #  end
    #else 
    #  @menutype  = $company_id
    #  @category = Category.categroytype(@menu,@menutype)
    ##  if  @category.size > 0 then
    #    for category in @category
    #      @title = category.categoryname
    #    end
     # end
    #end
    
    #读取技术专区主菜单
    @technology = Category.find(:all,
      :conditions => " categoryid = '" + params[:id]  + "'  and company_id ='" + @menutype.to_s + "'")      
    if @menutype.to_i == 1
      #读取市场应用子菜单
      if params[:id].length == 3
        @technologydetail = Category.find(:all,
          :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6 ",
          :order => "categoryorder") 
      else
        @technologydetail = Category.find(:all,
          :conditions => " substring(categoryid,1,6) = '" + params[:id]  + "' and length(categoryid) = 9 ",
          :order => "categoryorder")
      end  
    else
      #读取技术专区子菜单
      if params[:id].length == 3
        @technologydetail = Category.find(:all,
          :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6  and company_id ='" + @menutype.to_s + "'",
          :order => "categoryorder") 
      else
        @technologydetail = Category.find(:all,
          :conditions => " substring(categoryid,1,6) = '" + params[:id]  + "' and length(categoryid) = 9 and company_id ='" + @menutype.to_s + "'",
          :order => "categoryorder")
      end
    end 
  
  end
  
  #技术专区
  def technology_en
    @menu = params[:id]
    $company_id = params[:company]
    @menutype  = $company_id
    @category = EnCategory.categroytype(@menu,@menutype)
    if  @category.size > 0 then
      for category in @category        
        @title = category.categoryname
      end
    end
    
    #@lists = EnCategory.categroycompanyid(@menu)
    #if  @lists.size == 1 then
    #  for list in @lists
    #    @menutype  = list.company_id
    #    @title = list.categoryname
    #  end
    #else 
    #  @menutype  = $company_id
    #  @category = EnCategory.categroytype(@menu,@menutype)
    #  if  @category.size > 0 then
    #    for category in @category
    #      @title = category.categoryname
    #    end
    #  end
    #end
    
    #读取技术专区主菜单
    @technology = EnCategory.find(:all,
      :conditions => " categoryid = '" + params[:id]  + "'  and company_id ='" + @menutype.to_s + "'")      
    if @menutype.to_i == 1
      #读取市场应用子菜单
      if params[:id].length == 3
        @technologydetail = EnCategory.find(:all,
          :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6 ",
          :order => "categoryorder") 
      else
        @technologydetail = EnCategory.find(:all,
          :conditions => " substring(categoryid,1,6) = '" + params[:id]  + "' and length(categoryid) = 9 ",
          :order => "categoryorder")
      end  
    else
      #读取技术专区子菜单
      if params[:id].length == 3
        @technologydetail = EnCategory.find(:all,
          :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6  and company_id ='" + @menutype.to_s + "'",
          :order => "categoryorder") 
      else
        @technologydetail = EnCategory.find(:all,
          :conditions => " substring(categoryid,1,6) = '" + params[:id]  + "' and length(categoryid) = 9 and company_id ='" + @menutype.to_s + "'",
          :order => "categoryorder")
      end
    end 
  
  end
  
  #技术专区明细
  def technologydetail
    @menu = params[:id]
    @lists = Category.categroycompanyid(@menu)
    if  @lists.size == 1 then
      for list in @lists
        @menutype  = list.company_id
        @title = list.categoryname
      end
    else
      @menutype  = $company_id
      @category = Category.categroytype(@menu,@menutype)
      if  @category.size > 0 then
        for category in @category
          @title = category.categoryname
        end
      end
    end
    #读取市场应用主菜单
    @technology = Category.find(:all,
      :conditions => " categoryid = '" + params[:id]  + "'  and company_id ='" + @menutype.to_s + "'")
    
    @technologydetail = Categorylist.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'",
      :order => "created_at") 

  end
  
  #技术专区明细
  def technologydetail_en
    @menu = params[:id]
    @lists = EnCategory.categroycompanyid(@menu)
    if  @lists.size == 1 then
      for list in @lists
        @menutype  = list.company_id
        @title = list.categoryname
      end
    else
      @menutype  = $company_id
      @category = EnCategory.categroytype(@menu,@menutype)
      if  @category.size > 0 then
        for category in @category
          @title = category.categoryname
        end
      end
    end
    #读取市场应用主菜单
    @technology = EnCategory.find(:all,
      :conditions => " categoryid = '" + params[:id]  + "'  and company_id ='" + @menutype.to_s + "'")
    
    @technologydetail = EnCategorylist.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'",
      :order => "created_at") 

  end
  
  #ferrotec全球
  def ferroteclocations
    
  end
  #网站地图
  def ferrotecmap
    #if $company_id == 1 
    @companyid = 1
    @ferrotecmaps = Category.find_by_sql("select categories.* from categories,companies where categories.categoryid = companies.categoryid and categories.company_id = companies.id and companies.id <> 1
union all
SELECT * FROM
(select * from categories where id not in (select id from categories where length(categoryid) = 3 and company_id <> 1)
        and id not in (select id from categories where substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id <> 1)
        and id not in (select id from categories where substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id <> 1) 
        and id not in (select id from categories where substring(categoryid,1,3) = '001' and (length(categoryid) = 6 or length(categoryid) = 9) and company_id <> 1)
order by categoryid) as A  order by categoryid,id")
    #else
    # @ferrotecmaps = Category.find(:all,:conditions => " company_id = " + @companyid  ,:order => "categoryid")
    #end

  end
  
    #网站地图
  def ferrotecmap_en
    #if $company_id == 1 
    @companyid = 1
    @ferrotecmaps = EnCategory.find_by_sql("select en_categories.* from en_categories,en_companies where en_categories.categoryid = en_companies.categoryid and en_categories.company_id = en_companies.id and en_companies.id <> 1
union all
SELECT * FROM
(select * from en_categories where id not in (select id from en_categories where length(categoryid) = 3 and company_id <> 1)
        and id not in (select id from en_categories where substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id <> 1)
        and id not in (select id from en_categories where substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id <> 1) 
        and id not in (select id from en_categories where substring(categoryid,1,3) = '001' and (length(categoryid) = 6 or length(categoryid) = 9) and company_id <> 1)
order by categoryid) as A  order by categoryid,id")
    #else
    # @ferrotecmaps = Category.find(:all,:conditions => " company_id = " + @companyid  ,:order => "categoryid")
    #end

  end
  
  #公司介绍
  def companyintroduce
    @menu = params[:id]
    $company_id = params[:company]
    @lists = Category.categroycompanyid(@menu)
    if  @lists.size == 1 then
      for list in @lists
        @title = list.categoryname
        $company_id  = list.company_id
      end
    else
      @menutype  = $company_id
      @category = Category.categroytype(@menu,@menutype)
      if  @category.size > 0 then
        for category in @category
          @title = category.categoryname
        end
      end
    end
    
    @menutype  = $company_id
    @companyinfo = Company.find(:all,
      :conditions => " id = '" + @menutype.to_s  + "'")
    
    #@category = Category.find(:all,:conditions => " categoryid ='" + @menu + "'")
    
  end
  #公司介绍英文
  def companyintroduce_en
    @menu = params[:id]
    $company_id = params[:company]
    @lists = EnCategory.categroycompanyid(@menu)
    if  @lists.size == 1 then
      for list in @lists
        @title = list.categoryname
        $company_id  = list.company_id
      end
    else
      @menutype  = $company_id
      @category = EnCategory.categroytype(@menu,@menutype)
      if  @category.size > 0 then
        for category in @category
          @title = category.categoryname
        end
      end
    end
    @menutype  = $company_id
    @companyinfo = EnCompany.find(:all,
      :conditions => " id = '" + @menutype.to_s  + "'")
  end
  
  #发展历程
  def developcourse
    @menu = params[:id]
    @lists = Category.categroycompanyid(@menu)

    for list in @lists
      @title = list.categoryname
      $company_id  = list.company_id
    end
    
    @developcourses  = Categorylist.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'",
      :order => "title") 
  end
  
  #发展历程
  def developcourse_en
    @menu = params[:id]
    @lists = EnCategory.categroycompanyid(@menu)

    for list in @lists
      @title = list.categoryname
      $company_id  = list.company_id
    end
    
    @developcourses  = EnCategorylist.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'",
      :order => "title") 
  end
  
  #资质证书
  def certificate
    @menu = params[:id]  
    @lists = Category.categroycompanyid(@menu)

    for list in @lists
      @title = list.categoryname
    end
    @zzzh  = Categorylist.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'",
      :order => "created_at")    
  end
  
    #资质证书
  def certificate_en
    @menu = params[:id]  
    @lists = EnCategory.categroycompanyid(@menu)

    for list in @lists
      @title = list.categoryname
    end
    @zzzh  = EnCategorylist.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'",
      :order => "created_at")    
  end
  
  #工作机会
  def workchance   
    companyid = $company_id
    @company = Company.find(:all,
      :conditions => "id = '" + companyid.to_s + "'") 
    @menu = params[:id]
    @gzjh  = Order.paginate :page => params[:page], :per_page => 10,:conditions => "company_id = '" + companyid.to_s + "'",:order => "created_at"
  end

  def workinfo
    @menu = params[:id]
    @order= Order.find_by_sql("select * from orders where id = '" + params[:id] + "'")
  end
  
  #服务专区
  def serverareadetail 
    @menu = params[:id]  
    @serverarea = Category.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'")    
    for category in @serverarea
      @title = category.categoryname
    end
  end
  
  #服务专区 英文
  def serverareadetail_en 
    @menu = params[:id]  
    @serverarea = EnCategory.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'")    
    for category in @serverarea
      @title = category.categoryname
    end
  end
  
  #交通位置
  def trafficposition
    
  end
  #交通位置英文
  def trafficposition_en
    
  end
  #新闻中心
  def newscenter
    @menu = params[:id] 
    $company_id  = params[:company]
    companyid = $company_id   
    @news = Category.find(:all,
      :conditions => "substring(categoryid,1,3) = '" + params[:id] + "' and length(categoryid) = 6 and company_id ='" + companyid.to_s + "'")      
    
    if companyid.to_i == 1
      
      #最新新闻动态
      @newscenter  = Categorylist.find(:all,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname= '新闻动态'  ",
        :order => "categorylists.issuedate desc",
        :limit => 6)  
      #最新技术动态 
      @technology  = Categorylist.find(:all,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname= '技术中心' and categorylists.istechnologyarticle = 1",
        :order => "categorylists.issuedate desc",
        :limit => 3)  
    else
      @newscenter  = Categorylist.find(:all,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname = '新闻动态' and categories.company_id ='" + companyid.to_s + "'",           
        :order => "categorylists.issuedate desc",
        :limit => 6)  
      #最新技术动态 
      @technology  = Categorylist.find(:all,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname= '技术中心' and categorylists.istechnologyarticle = 1 and categories.company_id ='" + companyid.to_s + "'",           
        :order => "categorylists.issuedate desc",
        :limit => 3)  
    end    
  end
  
  #新闻中心 英文
  def newscenter_en
    @menu = params[:id] 
    $company_id  = params[:company]
    companyid = $company_id   
    @news = EnCategory.find(:all,
      :conditions => "substring(categoryid,1,3) = '" + params[:id] + "' and length(categoryid) = 6 and company_id ='" + companyid.to_s + "'")      
    
    if companyid.to_i == 1
#      @newscenter  = EnCategorylist.find(:all,
#        :conditions => "categoryid  like '005%'  ",
#        :order => "en_categorylists.issuedate desc",
#        :limit => 10)  
      @newslist =  EnCategorylist.paginate :page => params[:page],
        :per_page => 20,
        :conditions => " categoryid like '005%'"  ,:order => "issuedate desc"  
#     /** 
#      最新新闻动态
#      @newscenter  = EnCategorylist.find(:all,
#        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
#        :conditions => "en_categories.categoryname= '新闻动态'  ",
#        :order => "en_categorylists.issuedate desc",
#        :limit => 6)  
#      #最新技术动态 
#      @technology  = EnCategorylist.find(:all,
#        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
#        :conditions => "en_categories.categoryname= '技术中心' and en_categorylists.istechnologyarticle = 1",
#        :order => "en_categorylists.issuedate desc",
#        :limit => 3)  
#        */
    else
      @newslist =  EnCategorylist.paginate :page => params[:page],
        :per_page => 20,
        :conditions => " categoryid like '005%' and company_id='" +  companyid.to_s + "'"  ,:order => "issuedate desc" 
#      @newscenter  = EnCategorylist.find(:all,
#        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
#        :conditions => "en_categories.categoryname = '新闻动态' and en_categories.company_id ='" + companyid.to_s + "'",           
#        :order => "en_categorylists.issuedate desc",
#        :limit => 6)  
#      #最新技术动态 
#      @technology  = EnCategorylist.find(:all,
#        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
#        :conditions => "en_categories.categoryname= '技术中心' and en_categorylists.istechnologyarticle = 1 and en_categories.company_id ='" + companyid.to_s + "'",           
#        :order => "en_categorylists.issuedate desc",
#        :limit => 3)  
    end    
  end
  
  #新闻动态和新闻摘要
  def newsdynamic
    @menu = params[:id] 
    companyid = $company_id 
    @new =  Category.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'")
    
    for category in @new
      categoryname = category.categoryname
      @title = category.categoryname
    end
    if companyid.to_i == 1
      @newslist =  Categorylist.paginate :page => params[:page],
        :per_page => 10,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname = '" + categoryname + "'",           
        :order => "categorylists.issuedate desc"
    else
      @newslist =  Categorylist.paginate :page => params[:page],
        :per_page => 10,
        :conditions => " categoryid ='" +  params[:id] + "'"  ,:order => "issuedate desc"  
    end
  end
  
  #新闻动态和新闻摘要 英文
  def newsdynamic_en
    @menu = params[:id] 
    companyid = $company_id 
    @new =  EnCategory.find(:all,
      :conditions => "categoryid = '" + params[:id] + "'")
    
    for category in @new
      categoryname = category.categoryname
      @title = category.categoryname
    end
    if companyid.to_i == 1
      @newslist =  EnCategorylist.paginate :page => params[:page],
        :per_page => 10,
        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
        :conditions => "en_categories.categoryname = '" + categoryname + "'",           
        :order => "en_categorylists.issuedate desc"
    else
      @newslist =  EnCategorylist.paginate :page => params[:page],
        :per_page => 10,
        :conditions => " categoryid ='" +  params[:id] + "'"  ,:order => "issuedate desc"  
    end
  end
  
  #技术中心
  def newstechnology
    @menu = params[:id] 
  
    companyid = $company_id   
    @news = Category.find(:all,
      :conditions => "substring(categoryid,1,3) = '" + params[:id] + "' and length(categoryid) = 6 and company_id ='" + companyid.to_s + "'")      
    
    if companyid.to_i == 1
      
      #最新技术文章
      @technology0  = Categorylist.paginate :page => params[:page],:per_page => 15,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname= '技术中心' and categorylists.istechnologyarticle = 0  ",
        :order => "categorylists.issuedate desc"
      #最新技术动态 
      @technology1  = Categorylist.paginate :page => params[:wpage],:per_page => 15,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname= '技术中心' and categorylists.istechnologyarticle = 1 ",
        :order => "categorylists.issuedate desc"

    else
      #最新技术文章
      @technology0  = Categorylist.paginate :page => params[:page],:per_page => 15,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname = '技术中心' and categorylists.istechnologyarticle = 0 and categories.company_id ='" + companyid.to_s + "'",           
        :order => "categorylists.issuedate desc" 
      #最新技术动态  
      @technology1  = Categorylist.paginate :page => params[:wpage],:per_page => 15,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => "categories.categoryname= '技术中心' and categorylists.istechnologyarticle = 1 and categorylists.istechnologyarticle = 1 and categories.company_id ='" + companyid.to_s + "'",           
        :order => "categorylists.issuedate desc"
    end  
  end
  
  #技术中心 英文
  def newstechnology_en
    @menu = params[:id] 
  
    companyid = $company_id   
    @news = EnCategory.find(:all,
      :conditions => "substring(categoryid,1,3) = '" + params[:id] + "' and length(categoryid) = 6 and company_id ='" + companyid.to_s + "'")      
    
    if companyid.to_i == 1
      
      #最新技术文章
      @technology0  = EnCategorylist.paginate :page => params[:page],:per_page => 15,
        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
        :conditions => "en_categories.categoryname= '技术中心' and en_categorylists.istechnologyarticle = 0  ",
        :order => "en_categorylists.created_at"
      #最新技术动态 
      @technology1  = EnCategorylist.paginate :page => params[:wpage],:per_page => 15,
        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
        :conditions => "en_categories.categoryname= '技术中心' and en_categorylists.istechnologyarticle = 1 ",
        :order => "en_categorylists.created_at"

    else
      #最新技术文章
      @technology0  = EnCategorylist.paginate :page => params[:page],:per_page => 15,
        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
        :conditions => "en_categories.categoryname = '技术中心' and en_categorylists.istechnologyarticle = 0 and en_categories.company_id ='" + companyid.to_s + "'",           
        :order => "en_categorylists.created_at" 
      #最新技术动态  
      @technology1  = EnCategorylist.paginate :page => params[:wpage],:per_page => 15,
        :joins => "LEFT JOIN en_categories ON en_categories.categoryid = en_categorylists.categoryid",
        :conditions => "en_categories.categoryname= '技术中心' and en_categorylists.istechnologyarticle = 1  and en_categories.company_id ='" + companyid.to_s + "'",           
        :order => "en_categorylists.created_at"
    end  
  end
  
  #新闻详情
  def newsdetail
    @menu = params[:id]
    #一条新闻详细信息
    @categorylist = Categorylist.find(:all,
      :conditions => "id = '" + params[:id] + "'")      
    #读取标题
    if  @categorylist.size > 0 then
      for categoryname in @categorylist
        @title = categoryname.title
      end
    end 
  end
  
  #新闻详情
  def newsdetail_en
    @menu = params[:id]
    #一条新闻详细信息
    @categorylist = EnCategorylist.find(:all,
      :conditions => "id = '" + params[:id] + "'")      
    #读取标题
    if  @categorylist.size > 0 then
      for categoryname in @categorylist
        @title = categoryname.title
      end
    end 
  end
  
  #联系我们
  def contactus
    #读取产品信息
    #@contactus = Category.find(:all,:conditions => "substring(categoryid,1,3) = '002' and length(categoryid) = 6",:order => "categoryorder")   
    #@company = Company.find(:all,:conditions => " id <> 1")
    
    #读取子公司的联系我们信息
    @dahe = @category = Category.find(:all,
      :conditions => "categoryid = '001004'") 
    @shenhe = Category.find(:all,
      :conditions => "categoryid = '001023'")
    @hanhong = Category.find(:all,
      :conditions => "categoryid = '001034'")
    @aqm = Category.find(:all,
      :conditions => "categoryid = '001018'") 
    @wagen = Category.find(:all,
      :conditions => "categoryid = '001013'")

  end
  
    #联系我们
  def contactus_en
    #读取产品信息
    #@contactus = Category.find(:all,:conditions => "substring(categoryid,1,3) = '002' and length(categoryid) = 6",:order => "categoryorder")   
    #@company = Company.find(:all,:conditions => " id <> 1")
    
    #读取子公司的联系我们信息
    @dahe = @category = EnCategory.find(:all,
      :conditions => "categoryid = '001004'") 
    @shenhe = EnCategory.find(:all,
      :conditions => "categoryid = '001023'")
    @hanhong = EnCategory.find(:all,
      :conditions => "categoryid = '001031'")
    @aqm = EnCategory.find(:all,
      :conditions => "categoryid = '001018'") 
    @wagen = EnCategory.find(:all,
      :conditions => "categoryid = '001013'")

  end
  
  #TE解决方案
  def teresolvent
    @menu = "TE001"
    @contact  = Contacts.new
  end
  
  #添加留言
  def add_teresolvent
    @contacts = Contacts.new(params[:contact])
    if request.post? and params[:commit] == "提交"
      categoryid = params[:contact][:categoryid]
      @contacts.categoryid = params[:contact][:categoryid]
      @contacts.language = "cn"
      @contacts.save
      flash[:notice] = "提交成功！"
      
      @coontacts  = Contacts.new
      redirect_to :controller => 'content',:action => 'teresolvent',:id => categoryid
    else
      @contacts  = Contacts.new
      redirect_to :controller => 'content',:action => 'teresolvent',:id => categoryid
    end
  end
  
    #TE解决方案
  def teresolvent_en
    @menu = "TE001"
    @contact  = Contacts.new
  end
  
  #添加留言
  def add_teresolvent_en
    @contacts = Contacts.new(params[:contact])
    if request.post? and params[:commit] == "submit"
      categoryid = params[:contact][:categoryid]
      @contacts.categoryid = params[:contact][:categoryid]
      @contacts.language = "en"
      @contacts.save
      flash[:notice] = "succeed！"
      
      @coontacts  = Contacts.new
      redirect_to :controller => 'content',:action => 'teresolvent_en',:id => categoryid
    else
      @contacts  = Contacts.new
      redirect_to :controller => 'content',:action => 'teresolvent_en',:id => categoryid
    end
  end
  
  #主要产品父页面
  def mostlyproductfirst
    @menu = params[:id]
    $company_id = params[:company]
    companyid = $company_id  
    if companyid.to_i == 1
      #读取主产品信息
      @mostlyproduct = Category.find(:all,:conditions => " categoryid = '" + params[:id]  + "' and company_id = 1")
      #主产品大类明细
      @mostlyproductdetail = Category.find(:all,
        :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6 ",
        :order => "categoryorder")  
    else
      #读取主产品信息
      @mostlyproduct = Category.find(:all,:conditions => " categoryid = '" + params[:id]  + "' and company_id ='" + companyid.to_s + "'")
      #主产品大类明细
      @mostlyproductdetail = Category.find(:all,
        :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6 and company_id ='" + companyid.to_s + "'",
        :order => "categoryorder")
    end      
    #读取标题
    if  @mostlyproduct.size > 0 then
      for categoryname in @mostlyproduct
        @title = categoryname.categoryname
      end
    end  
  end
  
  #主要产品父页面 英文
  def mostlyproductfirst_en
    @menu = params[:id]
    $company_id = params[:company]
    companyid = $company_id  
    if companyid.to_i == 1
      #读取主产品信息
      @mostlyproduct = EnCategory.find(:all,:conditions => " categoryid = '" + params[:id]  + "' and company_id = 1")
      #主产品大类明细
      @mostlyproductdetail = EnCategory.find(:all,
        :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6 ",
        :order => "categoryorder")  
    else
      #读取主产品信息
      @mostlyproduct = EnCategory.find(:all,:conditions => " categoryid = '" + params[:id]  + "' and company_id ='" + companyid.to_s + "'")
      #主产品大类明细
      @mostlyproductdetail = EnCategory.find(:all,
        :conditions => " substring(categoryid,1,3) = '" + params[:id]  + "' and length(categoryid) = 6 and company_id ='" + companyid.to_s + "'",
        :order => "categoryorder")
    end      
    #读取标题
    if  @mostlyproduct.size > 0 then
      for categoryname in @mostlyproduct
        @title = categoryname.categoryname
      end
    end  
  end

  #技术指南
  def technologyguide
    @menu = params[:id]
    @menutype  = $company_id

    
    @technologyguide = Category.find(:all,
      :conditions => " categoryid = '" + params[:id]  + "'  and company_id ='" + @menutype.to_s + "'")
  end 
  
  
  #技术指南
  def technologyguide_en
    @menu = params[:id]
    @menutype  = $company_id

    
    @technologyguide = EnCategory.find(:all,
      :conditions => " categoryid = '" + params[:id]  + "'  and company_id ='" + @menutype.to_s + "'")
  end 
  
  #VF问询表
  def vfresolvent
    @menu = "VF001"
    @contact  = Contacts.new
  end
  
  #添加留言
  def add_vfresolvent
    @contacts = Contacts.new(params[:contact])
    if request.post? and params[:commit] == "提交"
      categoryid = params[:contact][:categoryid]
      @contacts.categoryid = params[:contact][:categoryid]
      @contacts.language = "cn"
      @contacts.save
      flash[:notice] = "提交成功！"
      
      @coontacts  = Contacts.new
      redirect_to :controller => 'content',:action => 'vfresolvent',:id => categoryid
    else
      @contacts  = Contacts.new
      redirect_to :controller => 'content',:action => 'vfresolvent',:id => categoryid
    end
  end
     #VF问询表
  def vfresolvent_en
    @menu = "VF001"
    @contact  = Contacts.new
  end
  
  #添加留言
  def add_vfresolvent_en
    @contacts = Contacts.new(params[:contact])
    if request.post? and params[:commit] == "submit"
      categoryid = params[:contact][:categoryid]
      @contacts.categoryid = params[:contact][:categoryid]
      @contacts.language = "en"
      @contacts.save
      flash[:notice] = "succeed！"
      
      @coontacts  = Contacts.new
      redirect_to :controller => 'content',:action => 'vfresolvent_en',:id => categoryid
    else
      @contacts  = Contacts.new
      redirect_to :controller => 'content',:action => 'vfresolvent_en',:id => categoryid
    end
  end
  #TE技术问题
  def technologyquestion
    
  end
  
  #VF基础信息
  def generalinformation
    
  end
  #VF定制产品
  def customseals
    
  end
  #VF专用磁流体密封产品
  def sealsforspecialized
    
  end
  #改装磁流体密封产品
  def retrofitseals
    
  end
  #气体和真空单元
  def gasandvacuumunions
    
  end
  #基本参数
  def commonspecifications
    
  end
  #如何订购
  def howtoorder
    
  end
  #马达集成
  def motorintegrated
    
  end
  
  def temperaturecontrollers_en
    
  end
  
  #TE技术指南明细
  def technologyguidedetail
    @menu = params[:id]
    
    @category  = Category.find(:all,
      :conditions => "categoryid = (select categoryid from categorylists where id='" + params[:id] + "')")
    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end 
    @technologyguide = Categorylist.find_by_sql("select de.id,de.categoryid,de.title,de.content,d.summary 
      from categories d,categorylists de where d.categoryid = de.categoryid 
      and d.categoryid = (select categoryid from categorylists where id='" + params[:id] + "')")
    
    @technologyguidedetail = Categorylist.find(:all,:conditions => " id = '" + params[:id] + "'")
  end
  
    
  #TE技术指南明细
  def technologyguidedetail_en
    @menu = params[:id]


 
    @category  = EnCategory.find(:all,
      :conditions => "categoryid = (select categoryid from en_categorylists where id='" + params[:id] + "')")

    #读取标题
    if  @category.size > 0 then
      for categoryname in @category
        @title = categoryname.categoryname
      end
    end 


    @technologyguide = EnCategorylist.find_by_sql("select de.id,de.categoryid,de.title,de.content,d.summary 
      from en_categories d,en_categorylists de where d.categoryid = de.categoryid 
      and d.categoryid = (select categoryid from en_categorylists where id='" + params[:id] + "')")
    
    @technologyguidedetail = EnCategorylist.find(:all,:conditions => " id = '" + params[:id] + "'")
  end
  
  def ferrotecdistributing
    
  end
  
  #证书预览
  def pictureview
    @menu = params[:id]
    @zs = Categorylist.find(:all,:conditions => " id = '" + params[:id] + "'")
  end
  
  #证书预览
  def pictureview_en
    @menu = params[:id]
    @zs = EnCategorylist.find(:all,:conditions => " id = '" + params[:id] + "'")
  end
  
  #和源主要产品明细下层信息
  def wagenmostlyproductdetailinfo
    @menu = params[:id]
    
    #明细
    @mostlyproductdetail = Category.find(:all,:conditions => " categoryid = '" + params[:id]  + "'")

    #读取标题
    if  @mostlyproductdetail.size > 0 then
      for categoryname in @mostlyproductdetail
        @title = categoryname.categoryname
      end
    end  
  end
  
  #和源主要产品明细下层信息 英文
  def wagenmostlyproductdetailinfo_en
    @menu = params[:id]
    
    #明细
    @mostlyproductdetail = EnCategory.find(:all,:conditions => " categoryid = '" + params[:id]  + "'")

    #读取标题
    if  @mostlyproductdetail.size > 0 then
      for categoryname in @mostlyproductdetail
        @title = categoryname.categoryname
      end
    end  
  end
  
  def ferrotectrafficposition_en
    @category =EnCategory.find(:all,:conditions => " categoryid = '" + params[:id]  + "'")
    for category in @category
      company_id = category.company_id
    end
    @menutype  = company_id
    @companies = EnCompany.find(:all,:conditions => " id = '" + @menutype.to_s  + "'")
  end
  
  def ferrotectrafficposition

    @category = Category.find(:all,:conditions => " categoryid = '" + params[:id]  + "'")
    for category in @category
      company_id = category.company_id
    end
    @menutype  = company_id
    @companies = Company.find(:all,:conditions => " id = '" + @menutype.to_s  + "'")
  end
  
  #磁流体参数表读取
  def querysetparam
    condition = ""
    if params[:shaftType] != "all"
      condition = condition + " shafttype ='" + params[:shaftType] + "' and"
    end     
    if params[:shaftDim] == "all-in" 
      condition = condition + " shaftdimensioncondition ='inch' and"
    end
    if params[:shaftDim] == "all-mm" 
      condition = condition + " shaftdimensioncondition ='mm' and"
    end
    if params[:shaftDim] != "all-in"  and params[:shaftDim] != "all-mm"  and  params[:shaftDim] != "all-all"
      condition = condition + " shaftdimension ='" + params[:shaftDim] + "' and"
    end
    
    if params[:mount] == "Other"
      condition = condition + " mountingtype not in ('Cartridge','Nose','Nut') and" 
    end
    
    if params[:mount] != "Other" and params[:mount] != "all"
      condition = condition + " mountingtype ='"+ params[:mount] + "' and" 
    end
    
    if params[:environment] != "all"
      condition = condition + " fluid ='"+ params[:environment] + "' and" 
    end
    
    @setparams = Setparam.find(:all,:conditions => condition.slice(0,condition.length-3))
    
  end
    
  #联系我们
  def companycontactus
    @menu = params[:id]
    if  params[:company].blank?
    @companycontactus = Category.find(:all,:conditions => " categoryid = '" + params[:id]  + "'")
    else
    @companycontactus = Category.find(:all,:conditions => " categoryid = '" + params[:id]  + "' and company_id ='" + params[:company] + "'")
    end
  end
  
    #联系我们
  def companycontactus_en
    @menu = params[:id]
    if  params[:company].blank?
    @companycontactus = EnCategory.find(:all,:conditions => " categoryid = '" + params[:id]  + "'")
    else
    @companycontactus = EnCategory.find(:all,:conditions => " categoryid = '" + params[:id]  + "' and company_id ='" + params[:company] + "'")
    end
  end

  def productverify
    lot = ""
    productno = ""
    if request.post? and params[:commit] == "提交"
      flash[:notice] = ""
      lot = params[:machinecode][:lot]
      productno = params[:machinecode][:productno]
      if codeok?(lot,productno)
        flash[:notice] = "验证通过"
      else
        flash[:notice] = "验证不通过"
      end
    end
  end

  def productquote
    if request.post? and params[:commit] == '计算价格'

      @t = params[:t].to_f
      @w = params[:w].to_f
      @d = params[:d].to_f
      @n = params[:n].to_f
      @df = params[:df]
      @dp = params[:dp]
      @gd = params[:gd]
      @dn = params[:dn]
#flash[:notice] = "齿数：#{@t}刃厚：#{@w}外径：#{@d}内径：#{@n}段付：#{@df}多片锯：#{@dp}刮刀：#{@gd}镀镍：#{@dn}"
      price = 0
      price = (320+(@t-96)*2)/0.9**((@d-300)/50)/0.96**((2-@w)*10) if @w < 2.0
      price = (320-(@t-96)*2)/0.9**((@d-300)/50)/0.96**((@w-3.2)*10) if @w > 3.2
      price = (320-(@t-96)*2)/0.9**((@d-300)/50) if @w >= 2.0 and @w <= 3.2
      price = case @df
              when 'single'
                price * (1+0.15)
              when 'double'
                price * (1+0.3)
              else
                price
              end
      price *= 1.2 if @dp == 'y'
      price += 15 if @n > 80
      price += 20 if @gd == 'y'
      price += (@d**2 * 3.14 * 5 / 20000) if @dn == 'y'

      flash[:notice] = "根据您要求的产品规格，报价为：#{price}"
    end
  end
end
