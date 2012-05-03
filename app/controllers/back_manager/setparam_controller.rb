class BackManager::SetparamController < ApplicationController
  before_filter :authorize, :except => :login
  layout "backmanager"
   def add_setparam
    @setparam = Setparam.new(params[:setparam])
    if request.post? 
      if @setparam.save
      flash.now[:notice] = "参数信息添加成功！"
      @setparam = Setparam.new
      else
        render :action => 'add_setparam'
      end 
    end
  end

  def edit_setparam
    @setparam = Setparam.find(params[:id])
  end

  def list_setparam
    #@all_setparams = setparam.find(:all)
    @all_setparams = Setparam.paginate :page => params[:page], :per_page => 23,:order => "created_at"
  end

  def delete_setparam
    if request.post?
      setparam = Setparam.find(params[:id])
      begin
        setparam.destroy
        flash[:notice] = "参数信息删除成功！"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_setparam)
  end
  
  def update_setparam
    @setparam = Setparam.find(params[:id])
    if @setparam.update_attributes(params[:setparam])
      flash[:notice] = '修改成功'
      redirect_to :action => 'list_setparam'
    else
      render :action => 'edit_setparam'
    end
  end
end
