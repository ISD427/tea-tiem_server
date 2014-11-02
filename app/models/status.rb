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

class Status < ActiveRecord::Base

# == association
    belongs_to :user


# == validation
    validates :status, # in ['IN','WAITING', 'OUT']
        inclusion: { in: ['IN', 'WAITING', 'OUT']}
end
