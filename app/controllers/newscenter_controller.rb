class NewscenterController < ApplicationController
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
    #newscenter(Category,params[:id],params[:company],"ch")
    navigation_menu(Category,params[:id],params[:company],"ch",5)
  end
  def index_en
    #newscenter(EnCategory,params[:id],params[:company],"en")
    navigation_menu(EnCategory,params[:id],params[:company],"en",5)
  end

end
