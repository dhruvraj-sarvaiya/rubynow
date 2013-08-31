# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation,:terms
  has_secure_password
  has_many :jobposts, dependent: :destroy
  has_many :usermemberships, dependent: :destroy
  #has_one :jobpost_details, through: :jobposts

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true   
  #validates :terms, presence:true  
  validates :terms, :acceptance => true, :presence =>{:message => ": You must agree terms for use and privacy policy to preceed"}

   def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
