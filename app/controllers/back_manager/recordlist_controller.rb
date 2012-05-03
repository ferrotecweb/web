class BackManager::RecordlistController < ApplicationController
  before_filter :authorize, :except => :login
  layout "backmanager"
  #require "active_support"
  #include ActiveSupport
  #require "win32ole"
  require 'iconv'
  
  require 'socket'
  include ApplicationHelper
  def log_query
    @hostname = Socket.gethostname

    #@client_ip = request.remote_ip
    @client_ip = request.env["REMOTE_HOST"]
    #@host_name = IPSocket.getaddress(request.remote_ip)    
    # @hostip = system("ipconfig") 
    @begindate = Time.now.strftime("%Y-%m-%d")
    @enddate = Time.now.strftime("%Y-%m-%d")
    @recordlists = Recordlist.find(:all,
        :conditions => " created_at >= '" + @begindate + 
          "' and created_at <= '" + @enddate + "'"
      )
    if params[:commit] == "查询"
      @recordlists = Recordlist.find(:all,
        :conditions => " created_at >= '" + params[:recordlist][:begindate] + 
          "' and created_at <= '" + params[:recordlist][:enddate] + "'"
      )
      @begindate = params[:recordlist][:begindate]
      @enddate = params[:recordlist][:enddate]
    end
    if params[:commit] == "导出Excel"
      #@recordlists = Recordlist.find(:all,
      #  :conditions => " created_at >= '" + params[:recordlist][:begindate] + 
      #    "' and created_at <= '" + params[:recordlist][:enddate] + "'"
      #)
      #array = Array.new
      #for i in 0..@recordlists.length-1
      #  item = OrderedHash.new
      #  item["操作对象"] = @recordlists[i].operatetype
      #  item["操作表"] = @recordlists[i].tablename
      #  item["操作表ID"] = @recordlists[i].categoryid
      #  item["操作时间"] = @recordlists[i].created_at.strftime("%Y-%m-%d")
      #  array << item
      #end
      #e = Excel::Workbook.new
      #e.addWorksheetFromArrayOfHashes("Log", array)
      #headers['Content-Type'] = "application/vnd.ms-excel"
      #render :text =>(e.build)
      cov = Iconv.new( 'gbk', 'utf-8')
      @recordlists = Recordlist.find(:all,
        :conditions => " created_at >= '" + params[:recordlist][:begindate] + 
          "' and created_at <= '" + params[:recordlist][:enddate] + "'"
      )
      @begindate = params[:recordlist][:begindate]
      @enddate = params[:recordlist][:enddate]
      
      
      excel = WIN32OLE.new "Excel.Application"
      excel.visible = true
      workbook = excel.workbooks.add

      worksheet = workbook.Worksheets(1) #定位到第一个sheet 
      #worksheet.Range('a3:d5').Interior['ColorIndex'] = 36
      worksheet.Range("a1")['Value']  = cov.iconv("操作对象")
      worksheet.Range("a1").ColumnWidth = 20 
      worksheet.Range("b1")['Value']  = cov.iconv("操作表")
      worksheet.Range("b1").ColumnWidth = 24 
      worksheet.Range("c1")['Value']  = cov.iconv("操作表ID")
      worksheet.Range("c1").ColumnWidth = 20 
      worksheet.Range("d1")['Value']  = cov.iconv("操作时间")
      worksheet.Range("d1").ColumnWidth = 20 
      worksheet.Range("e1")['Value']  = cov.iconv("对应公司")
      worksheet.Range("e1").ColumnWidth = 20    

    
      j = @recordlists.length + 1
      worksheet.Range("a1:e#{j}").NumberFormatLocal = "@"
      for i in 0..@recordlists.length-1
        worksheet.Range("a#{i+2}")['Value'] = cov.iconv(Recordlist.getoperatetype(@recordlists[i].operatetype))
        worksheet.Range("b#{i+2}")['Value'] = @recordlists[i].tablename
        worksheet.Range("c#{i+2}")['Value'] = @recordlists[i].categoryid
        worksheet.Range("d#{i+2}")['Value'] = @recordlists[i].created_at.strftime("%Y-%m-%d")
        worksheet.Range("e#{i+2}")['Value'] = cov.iconv(getcompanyname(@recordlists[i].company_id))
      end
    end
  end
end
