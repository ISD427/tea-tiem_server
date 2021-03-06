# == Schema Information
#
# Table name: activities
#
#  id            :integer          not null, primary key
#  user_id       :string(255)
#  activity_code :string(255)
#  message       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Activity < ActiveRecord::Base
#  == association
    belongs_to :user
end
