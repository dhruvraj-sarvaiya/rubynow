class Product < ActiveRecord::Base
	attr_accessible :name,:price, :description, :category_id
  belongs_to :category
end
