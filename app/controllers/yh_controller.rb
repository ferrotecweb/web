class YhController < ApplicationController
  layout "yh"
  before_filter :create_menu
  def index
    @company = Company.find(9)
    @news = Categorylist.all(:conditions=>"categoryid = '017001'", :limit=>5, :order=>"id desc")
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
      @submenus = Category.yh_sub_menu(categoryid)
      @content = Category.first(:conditions=>"substring(categoryid,1,3)='#{categoryid}' and length(categoryid) = 6 and company_id = 9",
                                :order => " categoryid")

    when 6
      @submenus = Category.yh_sub_menu(categoryid[0,3])
      @content = Category.find(categoryid)
    else
      @company = Company.find(9)
      @news = Categorylist.all(:conditions=>"categoryid = '017001'", :limit=>5)
      return render 'index'
    end

    # 017 为银和的新闻栏目，新闻栏目需要Categorylist的内容，故分开处理
    if categoryid[0,3] == '017'
      if categoryid.size == 6
        @news = Categorylist.paginate(:page => params[:page],
                                      :per_page => 10,
                                      :conditions => "categoryid ='#{categoryid}'")
      else
        @news = Categorylist.paginate(:page => params[:page],
                                      :per_page => 10,
                                      :conditions => "categoryid ='017001'")
      end
      return render 'newslist'
    end

  end

  def news
    id = params[:id]
    @new = Categorylist.find(id)
    render :layout => false
  end

private

  def create_menu
    @menus = Category.yh_main_menu
  end
end
