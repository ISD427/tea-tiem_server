# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  source_id  :string(255)
#  target_id  :string(255)
#  message    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  deleted    :boolean
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
