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

require 'test_helper'

class JobpostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
