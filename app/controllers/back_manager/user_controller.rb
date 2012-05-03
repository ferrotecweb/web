class BackManager::UserController < ApplicationController
  before_filter :authorize, :except => :login
   #layout "backmanager"
  layout :islogin
  #判定如果登陆成功就用admin布局，否则不使用布局
  def islogin
    if session[:user_id] != nil
      "backmanager"
    else
      nil
    end
  end
  #登陆成功后显示的页面
  def index
    #@total_orders = Order.count
  end

  #登陆
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:controller =>"/back_manager/category",:action => "index")
      else
        flash[:notice] = "无效的用户名或密码"
      end
    end
  end
  
  
  #t添加用户名
  def add_user
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash.now[:notice] = "用户名 #{@user.name} 添加成功！"
      @user = User.new
    end
  end
  
  #删除用户名
  def delete_user
    if request.post?
      user = User.find(params[:id])
      begin
        user.destroy
        flash[:notice] = "用户名 #{user.name} 删除成功"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_users)
  end
  
  #用户列表
  def list_users
    @all_users = User.find(:all)
  end
  
  def edit_user
    @user = User.find(params[:id])
  end
  
  def update_user
    @user = User.find(params[:id])
    user = User.authenticate(@user.name, params[:oldpassword].to_s)
    if user
      if @user.update_attributes(params[:user])
        flash[:notice] = '修改成功'
        redirect_to :action => 'list_users'
      else
        render :action => 'edit_user'
      end
    else
      flash[:notice] = '原密码输入错误'
      render :action => 'edit_user'
    end
  end
  
  #退出
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:controller =>"/back_manager/user",:action => "login")
  end
end
