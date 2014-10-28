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
end
