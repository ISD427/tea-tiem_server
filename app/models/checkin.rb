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

class Checkin < ActiveRecord::Base
end
