# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  source_id  :string(255)
#  target_id  :string(255)
#  count      :integer
#  first_time :boolean
#  created_at :datetime
#  updated_at :datetime
#  cafename   :string(255)
#  time       :datetime
#

class Friendship < ActiveRecord::Base
# == association
    belongs_to :source, class_name: "User"
    belongs_to :target, class_name: "User"

# == validation
end
