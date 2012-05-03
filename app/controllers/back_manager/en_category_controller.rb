class BackManager::EnCategoryController < ApplicationController
  before_filter :authorize, :except => :login
  layout "backmanager"
 
  def list_category
    id = params[:company_id]
    @companyid = id
    case  id.to_s
      when "1"
        @title = "集团公司栏目一览(英文)"
      when "2"
        @title = "杭州大和栏目一览(英文)"
      when "3"
        @title = "上海申和栏目一览(英文)"
      when "4"
        @title = "上海汉虹栏目一览(英文)"
      when "5"
        @title = "先进石英栏目一览(英文)"
      when "6"
        @title = "和源精密栏目一览(英文)"
    end
    #if id == "1" 
    #  @all_categorys = EnCategory.find(:all,:order => "categoryid")
    # else
    #  @all_categorys = EnCategory.find(:all,:conditions => " (company_id = " + @companyid  + " or length(categoryid) = 3)",:order => "categoryid")
    #end
    if id == "1" 
      #@all_categorys = EnCategory.find(:all,
      #  :conditions => "id not in (select id from categories where length(categoryid) = 3 and company_id <> 1)
      #  and id not in (select id from categories where substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id <> 1)
      #  and id not in (select id from categories where substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id <> 1)",
      #  :order => "categoryid")
      @all_categorys = EnCategory.find_by_sql("select en_categories.* from en_categories,en_companies where en_categories.categoryid = en_companies.categoryid and en_categories.company_id = en_companies.id and en_companies.id <> 1
union all
SELECT * FROM
(select * from en_categories where id not in (select id from en_categories where length(categoryid) = 3 and company_id <> 1)
        and id not in (select id from en_categories where substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id <> 1)
        and id not in (select id from en_categories where substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id <> 1) 
        and id not in (select id from en_categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id <> 1)
order by categoryid) as A  order by categoryid,id")
     else
      @all_categorys = EnCategory.find(:all,:conditions => " company_id = " + @companyid  ,:order => "categoryid")
    end
    
  end
  
  def add_category
    #添加标识
    @flag = 1
    @companyid = params[:company_id]
    @maxcategoryid = EnCategory.find_by_sql("select max(categoryid) as categoryid from en_categories 
where substring(categoryid,1,length('" + params[:categoryid].to_s + "')) = '" + params[:categoryid].to_s +
        "' and length(categoryid) = length('" + params[:categoryid].to_s + "') + 3")
    
    if @maxcategoryid.size > 0  then      
      for maxcategoryid in @maxcategoryid
        #如何没有下层
        if maxcategoryid.categoryid  != nil then
          categoryid = maxcategoryid.categoryid.slice(maxcategoryid.categoryid.length-2,2).to_i + 1
          if categoryid.to_s.length == 1  then
            categoryid = "0" + categoryid.to_s
          end
          @getmaxcategoryid = maxcategoryid.categoryid.slice(0,maxcategoryid.categoryid.length-2).to_s + categoryid.to_s
        else
          @getmaxcategoryid = params[:categoryid] + "001"
        end
      end
    
    end 

    @category = EnCategory.new(params[:category])

    if request.post? 
      @category.categoryid = params[:category][:categoryid]
      @category.created_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      if @category.save
        
      @record = Recordlist.new()
      @record.categoryid = params[:category][:categoryid]
      @record.userid = session[:user_id] 
      #操作 0为添加 1为修改 2为删除
      @record.operatetype = 0
      #操作表  0为中文,1为英文
      @record.tabletype = 1
      @record.tablename = "en_categories"
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
    #@category = EnCategory.find(params[:id])
    @temp = EnCategory.find(:all,:conditions => " categoryid ='" + params[:id] + "' and company_id = '" + @companyid.to_s + "'" )
    if  @temp.size > 0 then
      for category in @temp
        @category  = category
      end
    end
  end
  
  def update_category
    @companyid = params[:company_id]
    #@category = EnCategory.find(params[:id])
    @temp = EnCategory.find(:all,:conditions => " categoryid ='" + params[:id] + "' and company_id = '" + @companyid.to_s + "'" )
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
    @obj =  EnCategory.find(:all,:conditions => " categoryid ='" + params[:id] + "'" )
    if @obj.size > 1 
      if EnCategory.update_all("categoryname ='" + params[:category][:categoryname] + 
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
        @record.tabletype = 1
        @record.tablename = "en_categories"
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
        #对更新操作进行记录
        @record = Recordlist.new()
        @record.categoryid = params[:id]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 1
        #操作表  0为中文,1为英文
        @record.tabletype = 1
        @record.tablename = "en_categories"
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
    @companyid = params[:company_id]
    if request.post?
      @categorylist = EnCategory.find_by_sql("select t.categoryid from en_categories w,en_categorylists t
        where w.categoryid = t.categoryid and w.categoryid='" + params[:id] + "'")
      
      if @categorylist.size > 0 then
        flash[:notice] = '已存在该产品明细信息，不允许删除！'
        redirect_to(:action => :list_category,:company_id => @companyid)
        return
      end
      categoryid = params[:id]
     
      @categoryquery = EnCategory.find_by_sql("select categoryid from en_categories where 
substring(categoryid,1,length('" + categoryid +  "')) = '" + categoryid + "' and length(categoryid) = length('" + categoryid +  "') + 3" )
      
      if @categoryquery.size > 0 then
        flash[:notice] = '已存在该产品对的子产品，不允许删除！'
        redirect_to(:action => :list_category,:company_id => @companyid)
        return
      end
      
      category = EnCategory.find(params[:id])
      begin
        category.destroy
        @record = Recordlist.new()
        @record.categoryid = params[:id]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 2
        #操作表  0为中文,1为英文
        @record.tabletype = 1
        @record.tablename = "en_categories"
        @record.company_id = @companyid
        @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
        @record.save
        flash[:notice] = "栏目 #{category.categoryname} 删除成功"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_category,:company_id => @companyid)
  end
end
