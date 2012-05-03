class Recordlist < ActiveRecord::Base
  file_column :begindate
  file_column :enddate
  
  def self.getoperatetype(operatetype)
    case operatetype.to_i
    when 0
      operatetypename = "新增操作"
    when 1
      operatetypename = "修改操作"
    when 2
      operatetypename = "删除操作"
    end
    return operatetypename
  end
end
