class BackManager::CategorylistController < ApplicationController
  before_filter :authorize, :except => :login
  layout "backmanager"
  
  def add_categorylist
    @companyid = params[:company_id]
    #新增标识
    @flag = 1
    @categorylist = Categorylist.new(params[:categorylist])
    if request.post?
      @categorylist.categoryid = params[:categorylist][:categoryid]
      @categorylist.title = params[:categorylist][:title]
      if @categorylist.downloadfile != "" and @categorylist.downloadfile != nil
        @categorylist.downloadfile = uploadfile(params[:categorylist][:downloadfile]) 
      end 

      if @categorylist.save
      @record = Recordlist.new()
      @record.categoryid = @categorylist.id
      @record.userid = session[:user_id] 
      #操作 0为添加 1为修改 2为删除
      @record.operatetype = 0
      #操作表  0为中文,1为英文
      @record.tabletype = 0
      @record.tablename = "categorylists"
      @record.company_id = @companyid
      @record.host_ip = request.env["REMOTE_ADDR"]
      @record.host_name = request.env["REMOTE_HOST"]
      @record.save
        
      #flash.now[:notice] = "栏目 #{@categorylist.categoryname} 添加成功！"
      #@categorylist = CategoryList.new
      flash[:notice] = "标题 #{@categorylist.title} 添加成功！"
      redirect_to :action => 'list_categorylist',:company_id => @companyid
      else
        render :action => 'add_categorylist',:company_id => @companyid
      end 
    end
  end

  def edit_categorylist
    #修改标识
    @flag = 0
    @companyid = params[:company_id]
    @categorylist = Categorylist.find(params[:id])
  end

  def list_categorylist
    id = params[:company_id]
    @companyid = id
    case  id.to_s
      when "1"
        @title = "集团公司内容一览"
      when "2"
        @title = "杭州大和内容一览"
      when "3"
        @title = "上海申和内容一览"
      when "4"
        @title = "上海汉虹内容一览"
      when "5"
        @title = "先进石英内容一览"
      when "6"
        @title = "和源精密内容一览"
    end
    
    @all_categorylists = Categorylist.paginate :page => params[:page], 
            :per_page => 22,
            :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
            :conditions => " categories.company_id = " + @companyid  ,
            :order => "created_at desc"
  end
  
  def query_categorylist
    @companyid = params[:categorylist][:company_id]
    if params[:categorylist][:categoryid].to_s != nil and params[:categorylist][:categoryid].to_s != ""
      @all_categorylists = Categorylist.paginate :page => params[:page], 
        :per_page => 22,
        :joins => "LEFT JOIN categories ON categories.categoryid = categorylists.categoryid",
        :conditions => " categories.company_id = '" + @companyid.to_s  + "' and categorylists.categoryid ='" + params[:categorylist][:categoryid].to_s  + "'",
        :order => "created_at desc"        
    else
      @all_categorylists = Categorylist.paginate :page => params[:page], :per_page => 22,:order => "created_at desc"
    end
  end
  

  def delete_categorylist
    @companyid = params[:company_id]
    if request.post?
      categorylist = Categorylist.find(params[:id])
      begin
        categorylist.destroy
        @record = Recordlist.new()
        @record.categoryid = params[:id]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 2
        #操作表  0为中文,1为英文
        @record.tabletype = 0
        @record.tablename = "categorylists"
        @record.company_id = @companyid
        @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
        @record.save
        flash[:notice] = "标题 #{categorylist.title} 删除成功"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_categorylist,:company_id => @companyid)
  end

  def update_categorylist
    @companyid = params[:company_id]
    @categorylist = Categorylist.find(params[:id])
    if @categorylist.update_attributes(params[:categorylist])
      @record = Recordlist.new()
      @record.categoryid = params[:id]
      @record.userid = session[:user_id] 
      #操作 0为添加 1为修改 2为删除
      @record.operatetype = 1
      #操作表  0为中文,1为英文
      @record.tabletype = 0
      @record.tablename = "categorylists"
      @record.company_id = @companyid
      @record.host_ip = request.env["REMOTE_ADDR"]
      @record.host_name = request.env["REMOTE_HOST"]
      @record.save
      flash[:notice] = '修改成功'
      redirect_to :action => 'list_categorylist',:company_id => @companyid
    else
      render :action => 'edit_categorylist',:company_id => @companyid
    end
  end
end
