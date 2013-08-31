# == Schema Information
#
# Table name: jobposts
#
#  id            :integer          not null, primary key
#  post_title    :string(255)
#  city_state    :string(255)
#  country_id    :integer
#  referrer_code :string(255)
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Jobpost < ActiveRecord::Base
  attr_accessible :city_state, :country_id, :post_title, :referrer_code, :post_type, :is_full_telecommute_job
  belongs_to :user
  has_one :jobpostdetail, dependent: :destroy
  #belongs_to :jobpost_detail

  validates :post_title, presence: true, length: { maximum: 140 }
  validates :city_state, presence: true, length: { maximum: 100 }
  validates :referrer_code, presence: true, length: { maximum: 50 }
  validates :country_id, presence: true
  validates :user_id, presence: true

  validates :post_type, presence: true
  

  default_scope order: 'jobposts.created_at DESC'
end
