class PaymentBillingInfo < ActiveRecord::Base
  attr_accessible :add_1, :add_2, :city, :country_id, :first_name, :last_name, :payment_id, :phone, :state, :zip

  belongs_to :payment
end
