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

class Message < ActiveRecord::Base
# == association
    belongs_to :source, class_name: "User"
    belongs_to :target, class_name: "User"

# == validation
end
