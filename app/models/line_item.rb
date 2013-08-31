class LineItem < ActiveRecord::Base
	attr_accessible :cart, :product, :quantity, :unit_price
  belongs_to :cart
  belongs_to :product
  
  def full_price
    unit_price * quantity
  end
end
