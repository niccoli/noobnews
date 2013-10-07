class User < ActiveRecord::Base
  validates_uniqueness_of :user_name
  has_secure_password
  has_many :posts
  has_many :votes
  has_many :comments
end