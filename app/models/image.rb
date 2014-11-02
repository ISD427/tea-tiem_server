# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  user_id            :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Image < ActiveRecord::Base
# == association
    belongs_to :user
    has_attached_file :image,
        :styles => {
        :thumb  => "100x100",
            :medium => "200x200",
            :large => "600x400"
        },
        :storage => :s3,
        :s3_credentials => "#{Rails.root}/config/s3.yml",
        :path => ":attachment/:id/:style.:extension"


# == validation
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
