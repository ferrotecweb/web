class BackManager::DevelopcourseController < ApplicationController
  before_filter :authorize, :except => :login
   layout "backmanager"
  
  def add_developcourse
    @developcourse = developcourse.new(params[:developcourse])
    if request.post? 
      if @developcourse.save
      flash.now[:notice] = "发展历程信息添加成功！"
      @developcourse = Categorylist.new
      else
        render :action => 'add_developcourse'
      end 
    end
  end

  def edit_developcourse
    @developcourse = Categorylist.find(params[:id])
  end

  def list_developcourse
    @all_developcourses = Categorylist.paginate :page => params[:page], 
        :per_page => 22,
        :order => "title desc"

  end

  def delete_developcourse
    if request.post?
      
      developcourse = Categorylist.find(params[:id])
      begin
        developcourse.destroy
        flash[:notice] = "发展历程信息删除成功！"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_developcourse)
  end
  
  def update_developcourse
    @developcourse = Categorylist.find(params[:id])
    if @developcourse.update_attributes(params[:developcourse])
      flash[:notice] = '修改成功'
      redirect_to :action => 'list_developcourse'
    else
      render :action => 'edit_developcourse'
    end
  end
end
