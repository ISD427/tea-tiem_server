# == Schema Information
#
# Table name: users
#
#  id         :string(255)      not null, primary key
#  username   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
    self.primary_key =  :id

# == association
end
