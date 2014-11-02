# == Schema Information
#
# Table name: users
#
#  id                 :string(255)      not null, primary key
#  username           :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  sex                :string(255)
#  profile            :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  age                :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
