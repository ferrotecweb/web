class Order < ActiveRecord::Base
  belongs_to :company,:foreign_key => "company_id"

  def self.getusername(userid)
        user = User.find(:all,
      :conditions => "id = '" + userid.to_s  +  "'" )
    for username in user
      username  = username.name
    end
    return username
  end
end
