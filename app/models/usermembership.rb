class Usermembership < ActiveRecord::Base
  attr_accessible :end_date, :payment_id, :post_type, :start_date, :status, :user_id
  belongs_to :user
  belongs_to :payment
end
