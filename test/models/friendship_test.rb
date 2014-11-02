# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  source_id  :string(255)
#  target_id  :string(255)
#  first_time :boolean
#  created_at :datetime
#  updated_at :datetime
#  cafename   :string(255)
#  time       :datetime
#

require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
