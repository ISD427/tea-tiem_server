# == Schema Information
#
# Table name: users
#
#  id                 :string(255)      not null, primary key
#  username           :string(255)
#  age                :integer
#  created_at         :datetime
#  updated_at         :datetime
#  sex                :string(255)
#  profile            :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'open-uri'

class User < ActiveRecord::Base
    def image_from_url(url)
        self.image = open(url)
    end

    self.primary_key = :id
    has_attached_file :image, 
        styles: { large: "640x640>", medium: "320x320>", thumb: "60x60>", mosaic: "20x20>" },
        path: "#{Rails.root}/public/system/:class/:id/:attachment/:style.:extension",
        url: "/system/:class/:id/:attachment/:style.:extension"

# == association
    has_many :sends, class_name: "Message", foreign_key: "sid"
    has_many :receives, class_name: "Message", foreign_key: "tid"
    has_many :sources, class_name: "Friendship", foreign_key: "sid"
    has_many :targets, class_name: "Friendship", foreign_key: "tid"
    has_many :checks
    has_one :status

# == validation
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    validates :username, #1..20 chars
        length: { minimum: 1, maximum: 20 }
    validates :sex, # 'Male' or 'Female'
        inclusion: { in: ['Male', 'Female']}
    validates :age,
        numericality: { only_integer: true } # integer 
end
