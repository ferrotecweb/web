class FldController < ApplicationController
  layout "fld"
  before_filter :create_menu
  def index
    @company = Company.find(7)
  end

  def detail
    categoryid = params[:cont]
    # 根据栏目ID的长度确定处理方法
    # 如果长度为3，说明是从主菜单点击过来的
    # 这时，需要显示的内容为该菜单下的第一个子栏目的内容
    # 如果为6，说明就是要显示该栏目的内容
    # 除此之外，都不正确，就直接返回主页
    case categoryid.size
    when 3
      @submenus = Category.fld_sub_menu(categoryid)
      @content = Category.first(:conditions=>"substring(categoryid,1,3)='#{categoryid}' and length(categoryid) = 6 and company_id = 7",
                                :order => " categoryid")

    when 6
      @submenus = Category.fld_sub_menu(categoryid[0,3])
      @content = Category.find(categoryid)
    else
      return render 'index'
    end
  end

private

  def create_menu
    @menus = Category.fld_main_menu
  end
end
