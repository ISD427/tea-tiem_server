# == Schema Information
#
# Table name: tmpplaces
#
#  id         :integer          not null, primary key
#  user_id    :string(255)
#  cafename   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tmpplace < ActiveRecord::Base

# == association
    belongs_to :user


# == validation
    validates :cafename, #1..50 chars
        length: { minimum: 1, maximum: 50 }
end
