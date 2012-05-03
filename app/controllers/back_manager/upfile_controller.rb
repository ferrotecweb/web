class BackManager::UpfileController < ApplicationController
  before_filter :authorize, :except => :login
  layout "backmanager"

  def index

  end
  
  #上传文件
  def add_file
    @file = Upfile.new(params[:file])
    if request.post? 
      if @file.upfile != ""
        @file.upfile = upfile(params[:file][:upfile]) 
      end 
      if @file.save
        flash.now[:notice] = "文件 #{@file.filename} 上传成功！"
        @file = Upfile.new
      end 
    end
  end
  
  #删除文件
  def delete_file
    if request.post?
      file = Upfile.find(params[:id])
      begin
        Upfile.delete(file.upfile)
        file.destroy
        flash[:notice] = "文件 #{file.filename} 删除成功"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_file)
  end
  
  #文件列表
  def list_file
    @all_file = Upfile.find(:all)
  end

end
