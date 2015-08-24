class Micropost < ActiveRecord::Base


  validates :content, presence: true ,length: { maximum: 140}

  belongs_to :user
  belongs_to :parent, class_name:"User", foreign_key:"parent_id"
  has_many :comments
  has_many :goods
  has_many :reports

  mount_uploader :picture, PictureUploader

end
