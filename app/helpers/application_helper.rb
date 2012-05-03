# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  require "md5"
  require "date"
  #导航菜单统一方法
  #参数说明
  #objCategory:模式对象
  #categoryid:记录表categoryid
  #companyid:公司id
  #pagetype:区分是中文页面还是英文页面
  #menutype：点击的是哪个菜单（如公司介绍，主要产品等）
  #
  def navigation_menu(objCategory,categoryid,companyid,pagetype,menutype)
        
    $company_id = companyid.to_i
    @menuid =  categoryid    
    @pagetype = pagetype
    @lists = objCategory.categroycompanyid(@menuid)
    if  @lists.size == 1 then
      for list in @lists
        @menutype  = list.company_id
        @menu  = list.url
        $company_id = list.company_id
      end
    else 
      @menutype  = $company_id
      @category = objCategory.categroytype(@menuid,@menutype)
      if  @category.size > 0 then
        for category in @category
          @menu  = category.url
        end
      end
    end

    case $company_id.to_s
    when "1"
      @pagetitle = "Ferrotec中国集团"
    when "2"
      @pagetitle = "杭州大和热磁电子有限公司"
    when "3"
      @pagetitle = "上海申和热磁电子有限公司"
    when "4"
      @pagetitle = "上海汉虹精密机械有限公司"
    when "5"
      @pagetitle = "杭州先进石英材料有限公司"
    when "6"
      @pagetitle = "杭州和源精密工具有限公司"
    end
    
    case menutype.to_i
    when 1
      if @menutype.to_s == "1"
        if pagetype == "ch"
         @menutitle = "集团介绍"
        else
         @menutitle = "Ferrotec(CN)"
        end
      else
         if pagetype == "ch"
         @menutitle = "公司介绍"
         else
         @menutitle = "Company"
         end 
      end  
      menuid = "001"

    when 2
      if pagetype == "ch"
      @menutitle = "主要产品"
      else
      @menutitle = "Products"
      end 
      menuid = "002"
    when 3
      if pagetype == "ch"
      @menutitle = "市场应用"
      else
      @menutitle = "Markets"
      end
      menuid = "003"
    when 4
      if pagetype == "ch"
      @menutitle = "技术专区"
      else
      @menutitle = "Technology"
      end
      menuid = "004"
    when 5
      if pagetype == "ch"
      @menutitle = "新闻中心"
      else
      @menutitle = "News"
      end
      menuid = "005"
    when 6
      if pagetype == "ch"
      @menutitle = "服务专区"
      else
       @menutitle = "Support" 
      end
      menuid = "006"
    end
    if pagetype == "ch" 
    @firstmenu = "公司介绍"
    else
    @firstmenu = "Company"
    end
    case @menutype.to_s
      when "1"
        
        @imgurl = "/images/banner/skill.jpg"
        if pagetype == "ch" 
        @firstmenu = "集团介绍"
        @firsturl = "/ferrotec/index"
        @logo = "/images/index1.jpg"
        else
        @firstmenu = "Company"
        @firsturl = "/ferrotec/index_en"
        @logo = "/images/jituan_logo.jpg"
        end
      when "2"
        
        @imgurl = "/images/banner/skill.jpg"
        if pagetype == "ch" 
        @firsturl = "/dahe/index"
        @logo = "/images/logo1.jpg"
        else
        @firsturl = "/dahe/index_en" 
        @logo = "/images/dahe_logo.jpg"
        end
      when "3" 
        
        @imgurl = "/images/banner/skill3.jpg"
        if pagetype == "ch"
        @firsturl = "/shenhe/index"
        @logo = "/images/logo2.jpg"
        else
        @firsturl = "/shenhe/index_en"
        @logo = "/images/shenhe_logo.jpg"
        end
      when "4" 
        @logo = "/images/hanhong.jpg"
      when "5" 
        @logo = "/images/aqm.jpg"
        @imgurl = "/images/aqm/aqm1.jpg"
      when "6" 
        @logo = "/images/wagen.jpg"
        @imgurl = "/images/wagen/wagen5.jpg"
    end
    #menuchange菜单因为包含一个首页菜单，所以首页菜单是1，公司介绍开始是2。。。，所以这里进行了＋1处理
    menuchange(menutype.to_i+1,@menutype,pagetype)
    if @menutype.to_s  == "1"
      case menutype.to_i
      when 1
        if pagetype == "ch"
          @leftmenu = Category.find_by_sql("
            select categories.* from categories,companies 
            where categories.categoryid = companies.categoryid and categories.company_id = companies.id 
                  and companies.id <> 1 and categories.company_id <> 4
                  union all
                  SELECT * FROM
                  (select * from categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id = 1
                  order by categoryid) as A  order by categoryid,id")
        else
          @leftmenu = Category.find_by_sql("
            select en_categories.* from en_categories,en_companies
            where en_categories.categoryid = en_companies.categoryid and en_categories.company_id = en_companies.id 
                  and en_companies.id <> 1 and en_categories.company_id <> 4
                  union all
                  SELECT * FROM
                  (select * from en_categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id = 1
                  order by categoryid) as A  order by categoryid,id")
        end
      when 2
      @leftmenu = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '002' and length(categoryid) = 6 and company_id <> 4",
        :order => "categoryorder"
      )
      when 3
      @leftmenu = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id = 1",
        :order => "categoryorder"
      )   
      when 4
      @leftmenu = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '004' and length(categoryid) = 6",
        :order => "categoryorder"
      )  
      when 5
      @leftmenu = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder")  
      when 6
      @leftmenu = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '006' and length(categoryid) = 6 and company_id = 1",
        :order => "categoryorder"
      )  
      end
      
      if pagetype == "ch"
        @menu1 = Category.find_by_sql("
            select categories.* from categories,companies 
            where categories.categoryid = companies.categoryid and categories.company_id = companies.id 
                  and companies.id <> 1 and categories.company_id <> 4
            union all
            SELECT * FROM
            (select * from categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id = 1
            order by categoryid) as A  order by categoryid,id")
      else
        @menu1 = Category.find_by_sql("
            select en_categories.* from en_categories,en_companies 
            where en_categories.categoryid = en_companies.categoryid and en_categories.company_id = en_companies.id 
                  and en_companies.id <> 1 and en_categories.company_id <> 4
            union all
            SELECT * FROM
            (select * from en_categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id = 1
            order by categoryid) as A  order by categoryid,id")
      end
      @menu2 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '002' and length(categoryid) = 6 and company_id <> 4",
        :order => "categoryorder"
      )  
      @menu3 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id = 1",
        :order => "categoryorder"
      ) 
      @menu4 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '004' and length(categoryid) = 6",
        :order => "categoryorder"
      )  
      @menu5 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id =1",
        :order => "categoryorder")  
      @menu6 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '006' and length(categoryid) = 6 and company_id <> 4",
        :order => "categoryorder"
      ) 

    else

      @leftmenu = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '" + menuid + "' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder")
   
      #@title = "公司简介"
      @menu1 = objCategory.find(:all,
        :conditions => " substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder"
      )
      @menu2 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '002' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder"
      )  
      @menu3 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder"
      ) 
      @menu4 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '004' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder"
      )  
      @menu5 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder")  
      @menu6 = objCategory.find(:all,
        :conditions => "substring(categoryid,1,3) = '006' and length(categoryid) = 6 and company_id ='" + @menutype.to_s + "'",
        :order => "categoryorder")  

    end
  end
  
  def nav_link(categoryid)
    case categoryid.slice(0,3)
      when "001"
      linkurl = "/companyintro/index?id=" + categoryid
      when "002" 
      linkurl = "/mostlyproduct/index?id=" + categoryid
      when "003" 
      linkurl = "/marketapply/index?id=" + categoryid
      when "004" 
      linkurl = "/technology/index?id=" + categoryid
      when "005" 
      linkurl = "/newscenter/index?id=" + categoryid
      when "006" 
      linkurl = "/serverarea/index?id=" + categoryid
    end
    return linkurl
  end

  def nav_link_en(categoryid)
    case categoryid.slice(0,3)
      when "001"
      linkurl = "/companyintro/index_en?id=" + categoryid
      when "002"
      linkurl = "/mostlyproduct/index_en?id=" + categoryid
      when "003"
      linkurl = "/marketapply/index_en?id=" + categoryid
      when "004"
      linkurl = "/technology/index_en?id=" + categoryid
      when "005"
      linkurl = "/newscenter/index_en?id=" + categoryid
      when "006"
      linkurl = "/serverarea/index_en?id=" + categoryid
    end
    return linkurl
  end
  
  #获取父级菜单的url链接
  def url_link(objCategory,categoryid,companyid)
      categorys = objCategory.find(:all,
      :conditions => "categoryid = '" + categoryid + "' and  company_id ='" + companyid.to_s + "'") 
      if categorys.size > 0   
        for category in categorys
          url  = category.url
        end
      else
          url = nil
      end
      return url
  end
  
  
  def company_link(objcompany,categoryid,companyid)
      companys = objcompany.find(:all,
      :conditions => "categoryid = '" + categoryid + "' and  id ='" + companyid.to_s + "'")
      if companys.size > 0   
        for company in companys
          url  = company.url
        end
      else
          url = nil
      end
      return url
  end
    
  def companyname(categoryid)
    category = Category.find(:all,
      :conditions => "categoryid = '" + categoryid + "'") 
    for companyid in category
      companyid  = companyid.company_id
    end
    case companyid.to_s
      when "1"
      companynameforshort = "集团"
      when "2" 
      companynameforshort = "大和"
      when "3" 
      companynameforshort = "申和"
      when "4" 
      companynameforshort = "汉虹"
      when "5" 
      companynameforshort = "AQM"
      when "6" 
      companynameforshort = "和源"
    end
    return companynameforshort
  end
  
  #对名字的进行链接替换
  def replacenameoturl(content)
    if content.blank?
      categorycontent =""
    else
      if content.index("Ferrotec")      
        categorycontent = content.gsub(/Ferrotec/,"<a href=/ferrotec/index target=_blank>Ferrotec</a>")  
      end
      if content.index("热电技术指南")      
        categorycontent = content.gsub(/热电技术指南/,"<a href=/technology/index?id=004003001 target=_blank>热电技术指南</a>")  
      end 
      if content.index("热电致冷 VS 传统致冷技术")      
        categorycontent = content.gsub(/热电致冷 VS 传统致冷技术/,"<a href=/technology/index?id=004003002 target=_blank>热电致冷 VS 传统致冷技术</a")  
      end    
      if categorycontent == "" then
        categorycontent = content
      end
    end
    return categorycontent
  end
  
  #和源和aqm子页面导航菜单变化
  #主要是针对点击后的菜单颜色变化
  def menuchange(num,companyid,type)
    
    if companyid == 6

      if type == "ch"
        @minserverarea = Category.find(:first, :conditions => "company_id = 6 and substring(categoryid,1,3) = '006' and length(categoryid) = 6", :order => "categoryid")

        @wagenmenu1 = "/images/wagen/menu11.jpg"
        @wagenmenu2 = "/images/wagen/menu22.jpg"
        @wagenmenu3 = "/images/wagen/menu33.jpg"
        @wagenmenu4 = "/images/wagen/menu44.jpg"
        @wagenmenu5 = "/images/wagen/menu55.jpg"
        @wagenmenu6 = "/images/wagen/menu66.jpg"
        @wagenmenu7 = "/images/wagen/menu77.jpg" 
        case num
        when 1
          @wagenmenu1 = "/images/wagen/menu11.jpg"
        when 2
          @wagenmenu2 = "/images/wagen/menu2.jpg"
        when 3
          @wagenmenu3 = "/images/wagen/menu3.jpg"
        when 4
          @wagenmenu4 = "/images/wagen/menu4.jpg"
        when 5
          @wagenmenu5 = "/images/wagen/menu5.jpg"
        when 6
          @wagenmenu6 = "/images/wagen/menu6.jpg"
        when 7
          @wagenmenu7 = "/images/wagen/menu7.jpg"
        end
      else
        @minserverarea = EnCategory.find(:first, :conditions => "company_id = 6 and substring(categoryid,1,3) = '006' and length(categoryid) = 6", :order => "categoryid")

        @wagenmenu1 = "/images/wagen/en_menu11.jpg"
        @wagenmenu2 = "/images/wagen/en_menu22.jpg"
        @wagenmenu3 = "/images/wagen/en_menu33.jpg"
        @wagenmenu4 = "/images/wagen/en_menu44.jpg"
        @wagenmenu5 = "/images/wagen/en_menu55.jpg"
        @wagenmenu6 = "/images/wagen/en_menu66.jpg"
        @wagenmenu7 = "/images/wagen/en_menu77.jpg" 
        case num
        when 1
          @wagenmenu1 = "/images/wagen/en_menu11.jpg"
        when 2
          @wagenmenu2 = "/images/wagen/en_menu2.jpg"
        when 3
          @wagenmenu3 = "/images/wagen/en_menu3.jpg"
        when 4
          @wagenmenu4 = "/images/wagen/en_menu4.jpg"
        when 5
          @wagenmenu5 = "/images/wagen/en_menu5.jpg"
        when 6
          @wagenmenu6 = "/images/wagen/en_menu6.jpg"
        when 7
          @wagenmenu7 = "/images/wagen/en_menu7.jpg"
        end
      end 
    end
    
    if companyid == 5

      if type == "ch"
        @minserverarea = Category.find(:first, :conditions => "company_id = 5 and substring(categoryid,1,3) = '006' and length(categoryid) = 6", :order => "categoryid")

        @aqmmenu1 = "/images/aqm/menu1.jpg"
        @aqmmenu2 = "/images/aqm/menu2.jpg"
        @aqmmenu3 = "/images/aqm/menu3.jpg"
        @aqmmenu4 = "/images/aqm/menu4.jpg"
        @aqmmenu5 = "/images/aqm/menu5.jpg"
        @aqmmenu6 = "/images/aqm/menu6.jpg"
        @aqmmenu7 = "/images/aqm/menu7.jpg" 
        case num
        when 1
          @aqmmenu1 = "/images/aqm/menu1.jpg"
        when 2
          @aqmmenu2 = "/images/aqm/menu22.jpg"
        when 3
          @aqmmenu3 = "/images/aqm/menu33.jpg"
        when 4
          @aqmmenu4 = "/images/aqm/menu44.jpg"
        when 5
          @aqmmenu5 = "/images/aqm/menu55.jpg"
        when 6
          @aqmmenu6 = "/images/aqm/menu66.jpg"
        when 7
          @aqmmenu7 = "/images/aqm/menu77.jpg"
        end
      else
        @minserverarea = EnCategory.find(:first, :conditions => "company_id = 5 and substring(categoryid,1,3) = '006' and length(categoryid) = 6", :order => "categoryid")

        @aqmmenu1 = "/images/aqm/en_menu1.jpg"
        @aqmmenu2 = "/images/aqm/en_menu2.jpg"
        @aqmmenu3 = "/images/aqm/en_menu3.jpg"
        @aqmmenu4 = "/images/aqm/en_menu4.jpg"
        @aqmmenu5 = "/images/aqm/en_menu5.jpg"
        @aqmmenu6 = "/images/aqm/en_menu6.jpg"
        @aqmmenu7 = "/images/aqm/en_menu7.jpg" 
        case num
        when 1
          @aqmmenu1 = "/images/aqm/en_menu1.jpg"
        when 2
          @aqmmenu2 = "/images/aqm/en_menu22.jpg"
        when 3
          @aqmmenu3 = "/images/aqm/en_menu33.jpg"
        when 4
          @aqmmenu4 = "/images/aqm/en_menu44.jpg"
        when 5
          @aqmmenu5 = "/images/aqm/en_menu55.jpg"
        when 6
          @aqmmenu6 = "/images/aqm/en_menu66.jpg"
        when 7
          @aqmmenu7 = "/images/aqm/en_menu77.jpg"
        end
      end
    end
  end
   
  def getcompanyname(companyid)
    company = Company.find(:all,
      :conditions => "id = '" + companyid.to_s  +  "'" ) 
    for companyname in company
      companyname  = companyname.companyname
    end

    return companyname
  end
  
  def getcompanyname_en(companyid)
    case companyid.to_s
      when "1"
      companynameforshort = "Ferrotec"
      when "2" 
      companynameforshort = "FTH"
      when "3" 
      companynameforshort = "FTS"
      when "4" 
      companynameforshort = "Hanhong"
      when "5" 
      companynameforshort = "AQM"
      when "6" 
      companynameforshort = "Wagen"
    end
    return companynameforshort
  end


    # 生成年的代码
  def YearCode(date)
    date.year
  end

  # 生成简单的校验码
  def geneSampleCode(lot)
    max = 0
    (1..lot.length).each do |i|
      max += lot[i-1,1].to_i
    end
    (max % 10).to_s
  end

  def geneCompleteCode(pre_code)
    fir = MD5.hexdigest("FERROTEC"+pre_code+"WAGEN")[0,1].upcase
    sec = MD5.hexdigest("FERROTEC"+pre_code+fir+"SOFTWARE")[1,1].upcase
    thi = MD5.hexdigest("YANGXD"+pre_code+fir+sec+"SHIE")[2,1].upcase
    fir + sec + thi
  end

  #生成防伪码，输入参数为LOT以及生成的日期，
  #返回生成的防伪码
  def geneCode(lot, date)

    #年代码
    year_code = (date.year % 10).to_s
    lot += year_code

    #月代码
    month_code = (date.month-1) * 3 + ((date.day-1) / 10)
    if month_code > 9
      month_code = "" << (month_code - 10 + 'A'[0])
    else
      month_code = month_code.to_s
    end
    lot += month_code

    #简单校验
    sample_code = geneSampleCode(lot)
    lot += sample_code

    # 机器校码
    verify_code = geneCompleteCode(lot)

    # 字符替换
    a = year_code + month_code + sample_code + verify_code
  #  a = a.gsub(/O/,'y')
  #  a = a.gsub(/0/,'s')
  #  a = a.gsub(/1/,'c')
  #  a = a.gsub(/I/,'x')
    a.gsub(/O/,'#').gsub(/0/,'$').gsub(/1/,'%').gsub(/I/,'&')
  end

  def yearcodeok?(year)
    year == year.to_i.to_s
  end

  def monthcodeok?(month)
    if (month[0] >= 'A'[0] && month[0] <= 'Z'[0]) ||
        month.to_i.to_s == month
      return true
    else
      return false
    end
  end

  def codeok?(lot,code)
    begin
      code = code.gsub(/#/,'O').gsub(/\$/,'0').gsub(/%/,'1').gsub(/&/,'I')

      year_code = code[0,1]
      month_code = code[1,1]
      sample_code = code[2,1]
      verify_code = code [3,3]

      if !yearcodeok?(year_code) ||
         !monthcodeok?(month_code) ||
         sample_code != geneSampleCode(lot+year_code+month_code) ||
         verify_code != geneCompleteCode(lot+year_code+month_code+sample_code)
        return false
      else
        return true
      end
    rescue
      return false
    end
  end

  def agent_login_required
    agent_logged_in? || agent_access_denied
  end

  def agent_access_denied
    redirect_to new_session_path
    false
  end

  def current_agent
    @current_agent ||= (agent_login_from_session || false)
  end

  alias :agent_logged_in? :current_agent

  def current_agent=(new_agent)
    session[:agents] = new_agent && new_agent.id
    @current_agent = new_agent
  end
  
  def agent_login_from_session
    self.current_agent = Agents.find_by_id(session[:agents]) if session[:agents]
  end
end
