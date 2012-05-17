class BackManager::CategoryController < ApplicationController
  before_filter :authorize, :except => :login
  layout "backmanager"
  
  def index
    
  end
  
  def list_category
    id = params[:company_id]
    @companyid = id
    case  id.to_s
      when "1"
        @title = "集团公司栏目一览"
      when "2"
        @title = "杭州大和栏目一览"
      when "3"
        @title = "上海申和栏目一览"
      when "4"
        @title = "上海汉虹栏目一览"
      when "5"
        @title = "先进石英栏目一览"
      when "6"
        @title = "和源精密栏目一览"
      when "7"
        @title = "富乐德栏目一览"
    end
    if id == "1" 
      @all_categorys = Category.find_by_sql("select categories.* from categories,companies 
        where categories.categoryid = companies.categoryid and categories.company_id = companies.id and companies.id <> 1
        union all
        SELECT A.* FROM
        (select categories.* from categories where id not in (select id from categories where length(categoryid) = 3 and company_id <> 1)
                and id not in (select id from categories where substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id <> 1)
                and id not in (select id from categories where substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id <> 1) 
                and id not in (select id from categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id <> 1)
        order by categoryid) as A  order by categoryid,id")
     else
      @all_categorys = Category.find(:all,:conditions => " company_id = " + @companyid  ,:order => "categoryid")
    end
  end

  def add_category
    #添加标识
    @flag = 1
    @companyid = params[:company_id]
    categoryid = params[:categoryid].to_s
    @maxcategoryid = Category.find_by_sql("select max(categoryid) as categoryid from categories
      where substring(categoryid,1,length('#{categoryid}')) = '#{categoryid}' and 
            length(categoryid) = length('#{categoryid}') + 3")
    if @maxcategoryid.size > 0  then
      for maxcategoryid in @maxcategoryid
        #如果没有下层
        if maxcategoryid.categoryid  != nil then
          categoryid = maxcategoryid.categoryid.slice(maxcategoryid.categoryid.length-2,2).to_i + 1
          if categoryid.to_s.length == 1  then
            categoryid = "0" + categoryid.to_s
          end
          @getmaxcategoryid = maxcategoryid.categoryid.slice(0,maxcategoryid.categoryid.length-2).to_s + categoryid.to_s
        else
          @getmaxcategoryid = params[:categoryid].to_s + "001"
        end
      end
    end 

    @category = Category.new(params[:category])

    if request.post? 
      @category.categoryid = params[:category][:categoryid]
      if @category.save
        
        @record = Recordlist.new()
        @record.categoryid = params[:category][:categoryid]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 0
        #操作表  0为中文,1为英文
        @record.tabletype = 0
        @record.tablename = "categories"
        @record.company_id = @companyid
        @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
        @record.save
        flash[:notice] = "栏目 #{@category.categoryname} 添加成功！"
        #page<<"alert('添加成功');"   
        redirect_to :action => 'list_category',:company_id =>@companyid
      else
        @flag = 1
        @getmaxcategoryid = @category.categoryid
        #:categoryid => @category.categoryid.slice(0,@category.categoryid.length-3)
        render :action => 'add_category',:company_id => @companyid
      end 
    end
  end
  
  def edit_category
    @companyid = params[:company_id]
    #修改标识
    @flag = 0
    @categoryid = params[:id]
    #@category = Category.find(params[:id])
    @temp = Category.find(:all,:conditions => " categoryid ='" + params[:id] + "' and company_id = '" + @companyid.to_s + "'" )
    if  @temp.size > 0 then
      #@category =@temp[0]
      for category in @temp
        @category  = category
      end
    end
  end
  
  def update_category
    @companyid = params[:company_id]
    #@category = Category.find(params[:id])
    @temp = Category.find(:all,:conditions => " categoryid ='" + params[:id] + "' and company_id = '" + @companyid.to_s + "'" )
    if  @temp.size > 0 then
      for category in @temp
        @category  = category
      end
    end
    if params[:category][:deletesummarypic] == "1"
      params[:category][:summarypic] = nil
    end
    if params[:category][:deletesmallsummarypic] == "1"
      params[:category][:picture] = nil
    end
    @obj =  Category.find(:all,:conditions => " categoryid ='" + params[:id] + "'" )
    if @obj.size > 1 
      if Category.update_all("categoryname ='" + params[:category][:categoryname] + 
            "',categoryorder='" + params[:category][:categoryorder] + 
            "',summary='" + params[:category][:summary] +
            "',content='" + params[:category][:content] +
            "',summarydetail='" + params[:category][:summarydetail] +
            "'"," categoryid ='" + params[:id] + "' and company_id = '" + @companyid.to_s + "'")
        #对更新操作进行记录
        @record = Recordlist.new()
        @record.categoryid = params[:id]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 1
        #操作表  0为中文,1为英文
        @record.tabletype = 0
        @record.tablename = "categories"
        @record.company_id = @companyid
        @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
        @record.save
        flash[:notice] = '修改成功'
        redirect_to :action => 'list_category',:company_id => @companyid
      else
        render :action => 'edit_category',:company_id => @companyid
      end
    else
      if @category.update_attributes(params[:category])
        @record = Recordlist.new()
        @record.categoryid = params[:id]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 1
        #操作表  0为中文,1为英文
        @record.tabletype = 0
        @record.tablename = "categories"
        @record.company_id = @companyid
        @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
        @record.save
        flash[:notice] = '修改成功'
        redirect_to :action => 'list_category',:company_id => @companyid
      else
        render :action => 'edit_category',:company_id => @companyid
      end
    end 
  end
  
  def delete_category
    companyid = params[:company_id]
    categoryid = params[:id]
    if request.post?
      @categorylist = Category.find_by_sql("select t.categoryid from categories w,categorylists t
        where w.categoryid = t.categoryid and w.categoryid='#{categoryid}' and w.company_id = #{companyid}")

      if @categorylist.size > 0 then
        flash[:notice] = '该栏目下已存在内容，不允许删除！'
        redirect_to(:action => :list_category,:company_id => companyid)
        return
      end

      @categoryquery = Category.find_by_sql("select categoryid from categories where company_id = #{companyid} and  
        substring(categoryid,1,length('#{categoryid}')) = '#{categoryid}' and length(categoryid) = length('#{categoryid}') + 3" )

      if @categoryquery.size > 0 then
        flash[:notice] = '该栏目下已存在子栏目，不允许删除！'
        redirect_to(:action => :list_category,:company_id => companyid)
        return
      end

      category = Category.find(params[:id])
      begin
        category.destroy
        @record = Recordlist.new()
        @record.categoryid = params[:id]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 2
        #操作表  0为中文,1为英文
        @record.tabletype = 0
        @record.tablename = "categories"
        @record.company_id = companyid
        @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
        @record.save
        flash[:notice] = "栏目 #{category.categoryname} 删除成功"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_category,:company_id => companyid)
  end

end
