class MostlyproductController < ApplicationController
  include ApplicationHelper
  layout :islayout
  #判定如果登陆成功就用admin布局，否则不使用布局
  def islayout
    #$company_id = params[:company].to_i
    case $company_id
    when 6
      "wagen"
    when 5
      "aqm"
    else
      "application"
    end
  end 
  

  
  def index
    #mostlyproduct(Category,params[:id],params[:company],"ch")
    navigation_menu(Category,params[:id],params[:company],"ch",2)

  end
  def index_en
    #mostlyproduct(EnCategory,params[:id],params[:company],"en")
    navigation_menu(EnCategory,params[:id],params[:company],"en",2)
  end
  
  def wagen_index
    @menutitle = "产品介绍"
    @menuid = "002"
    @menu  = "/content/wagenmostlyproduct?id=002"
  end
  
  
end
