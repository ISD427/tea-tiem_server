# == Schema Information
#
# Table name: checkins
#
#  id         :integer          not null, primary key
#  user_id    :string(255)
#  cafename   :string(255)
#  action     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CheckinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
