# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  user_id    :string(255)
#  cafename   :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
