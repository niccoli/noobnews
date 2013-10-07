class Vote < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => [:post_id]
  belongs_to :post
  belongs_to :user  
end