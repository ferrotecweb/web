class BackManager::ContactController < ApplicationController
  before_filter :authorize, :except => :login
  layout "backmanager"
  
  def te_detail_contact
    @contact = Contacts.find(params[:id])
  end
  
  def vf_detail_contact
    @contact = Contacts.find(params[:id])
  end

  def list_contact
    @contacts= Contacts.paginate :page => params[:page], 
      :per_page => 23,
      :conditions => " (categoryid ='TE001' or categoryid ='VF001') ",
      :order => "created_at"
  end
  
  def delete_contact
    if request.post?
      contact = Contacts.find(params[:id])
      begin
        contact.destroy
        flash[:notice] = "删除成功"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_contact)
  end
end
