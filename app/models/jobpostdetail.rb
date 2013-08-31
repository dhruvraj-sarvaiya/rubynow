class Jobpostdetail < ActiveRecord::Base
  attr_accessible :company, :company_url, :description, :how_to_apply,  :type_of_position, :work_hours

  belongs_to :jobpost
end
