class User < ActiveRecord::Base
  has_many :comments
  has_many :microposts
  has_many :goods
  has_secure_password


end
