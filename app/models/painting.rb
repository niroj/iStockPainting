class Painting < ActiveRecord::Base
  attr_accessible :title, :credits, :inspiration, :image, :remote_image_url
  belongs_to :user
  mount_uploader :image, ImageUploader
end
