class Micropost < ActiveRecord::Base


  validates :content, presence: true ,length: { maximum: 140}

  belongs_to :user
  has_many :comments
  has_many :goods
end
