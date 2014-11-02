# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  user_id            :string(255)
#  deleted            :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#
require "open-uri"

class Image < ActiveRecord::Base
    def image_from_url(url)
        self.image = open(url)
    end

# == association
    belongs_to :user
    has_attached_file :image,
        :styles => {
        :thumb  => "100x100",
            :medium => "200x200",
            :large => "600x400"
        },
        # :storage => :s3,
        # :s3_credentials => "#{Rails.root}/config/s3.yml",
        # :path => ":attachment/:id/:style.:extension"
        path: "#{Rails.root}/public/system/:class/:id/:style.:extension",
        url: "/system/:class/:id/:style.:extension"

# == validation
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
