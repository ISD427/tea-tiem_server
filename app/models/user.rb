# == Schema Information
#
# Table name: users
#
#  id         :string(255)      not null, primary key
#  username   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  sex        :string(255)
#  profile    :string(255)
#

class User < ActiveRecord::Base
    self.primary_key = :id

# == association
    has_many :sends, class_name: "Message", foreign_key: "sid"
    has_many :receives, class_name: "Message", foreign_key: "tid"
    has_many :sources, class_name: "Friendship", foreign_key: "sid"
    has_many :targets, class_name: "Friendship", foreign_key: "tid"
    has_many :checks
    has_one :status
    has_many :images

# == validation
    validates :username, #1..20 chars
        length: { minimum: 1, maximum: 20 }
    validates :sex, # 'Male' or 'Female'
        inclusion: { in: ['Male', 'Female']}
end
