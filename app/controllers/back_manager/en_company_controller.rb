class BackManager::EnCompanyController < ApplicationController
    before_filter :authorize, :except => :login
  layout "backmanager"
  
  def add_company
    @company = EnCompany.new(params[:company])
    if request.post? 
      if @company.save
        
      @record = Recordlist.new()
      @record.categoryid = @company.id
      @record.userid = session[:user_id] 
      #操作 0为添加 1为修改 2为删除
      @record.operatetype = 0
      #操作表  0为中文,1为英文
      @record.tabletype = 1
      @record.tablename = "en_companies"
      @record.company_id = @company.id
      @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
      @record.save
      flash.now[:notice] = "公司信息添加成功！"
      @company = EnCompany.new
      else
        render :action => 'add_company'
      end 
    end
  end

  def edit_company
    @company = EnCompany.find(params[:id])
  end

  def list_company
    @all_companys = EnCompany.find(:all)
  end

  def delete_company
    if request.post?
      #已应用的公司不允许删除
      @company = EnCategory.find(:all,
           :conditions => "company_id = '" + params[:id] + "'") 
      
      if @company.size > 0 then
        flash[:notice] = '该公司信息已被引用，不允许删除！'
        redirect_to(:action => :list_company)
        return
      end
      
      company = EnCompany.find(params[:id])
      begin
        company.destroy
        @record = Recordlist.new()
        @record.categoryid = params[:id]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 2
        #操作表  0为中文,1为英文
        @record.tabletype = 1
        @record.tablename = "en_companies"
        @record.company_id = params[:id]
        @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
        @record.save
        flash[:notice] = "招聘信息删除成功！"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_company)
  end
  
  def update_company
    @company = EnCompany.find(params[:id])
    if @company.update_attributes(params[:company])
        @record = Recordlist.new()
        @record.categoryid = params[:id]
        @record.userid = session[:user_id] 
        #操作 0为添加 1为修改 2为删除
        @record.operatetype = 1
        #操作表  0为中文,1为英文
        @record.tabletype = 1
        @record.tablename = "en_companies"
        @record.company_id = params[:id]
        @record.host_ip = request.env["REMOTE_ADDR"]
        @record.host_name = request.env["REMOTE_HOST"]
        @record.save
      flash[:notice] = '修改成功'
      redirect_to :action => 'list_company'
    else
      render :action => 'edit_company'
    end
  end
end
