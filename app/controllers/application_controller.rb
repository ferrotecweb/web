# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '7b49793d06b0d3296d4e6a684ad5cba9'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :initialization
  private
 
  def initialization
#集团公司 
#      @menu1 = Category.find_by_sql("select categories.* from categories,companies where categories.categoryid = companies.categoryid and categories.company_id = companies.id and companies.id <> 1
#union all
#SELECT * FROM
#(select * from categories where substring(categoryid,1,3) = '001' and length(categoryid) = 6 and company_id = 1
#order by categoryid) as A  order by categoryid,id")      
#      #主要产品 
#      @menu2 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '002' and length(categoryid) = 6",:order => "categoryorder")      
#      #市场应用
#      @menu3 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '003' and length(categoryid) = 6 and company_id = 1",:order => "categoryorder")      
#      #技术专区
#      @menu4 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '004' and length(categoryid) = 6",:order => "categoryorder")      
#      #新闻中心
#      @menu5 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '005' and length(categoryid) = 6 and company_id = 1",:order => "categoryorder")      
#      #服务专区
#      @menu6 = Category.find(:all,:conditions => "substring(categoryid,1,3) = '006' and length(categoryid) = 6",:order => "categoryorder")   
#      #主菜单
      #@company_id = 1
      #测试
  end
  
  #用户
  def authorize
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "对不起，请先登陆"
      redirect_to(:controller => "user", :action => "login")
    end
  end
  
  
  before_filter :configure_charsets      
   
  def configure_charsets            
     headers["Content-Type"]="text/html;charset=utf-8"        
  end  
  
  def uploadfile(file)      
     if !file.original_filename.empty?    
       #生成一个随机的文件名        
       @filename=getfilename(file.original_filename)           
       #向dir目录写入文件    
       File.open("#{RAILS_ROOT}/public/download/#{@filename}", "wb") do |f|     
          f.write(file.read)    
       end     
       #返回文件名称，保存到数据库中    
       return @filename   
     end    
  end     
  

  
  def upfile(file)      
     if !file.original_filename.empty?    
       #生成一个随机的文件名        
       @filename=getfilename(file.original_filename)           
       #向dir目录写入文件    
       File.open("#{RAILS_ROOT}/public/sharefile/#{@filename}", "wb") do |f|     
          f.write(file.read)    
       end     
       #返回文件名称，保存到数据库中    
       return @filename   
     end    
  end  
   
  def getfilename(filename)    
     if !filename.nil?  
       #下载uuidtools gem install uuidtools
       #require 'uuidtools'    
       #filename.sub(/.*./,UUID.random_create.to_s+'.')  
       
       #获取文件后缀名
       backname = File.extname(filename) 
       filename.sub(/.*./,Time.now.to_i.to_s+backname)  
     end    
  end   
end
