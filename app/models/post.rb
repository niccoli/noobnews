class Post < ActiveRecord::Base
  validates :description, :presence => true
  validates :link, :presence => true
  validates :user_id, :presence => true
  validates :description, :length => { :maximum => 150 }
  belongs_to :user
  has_many :votes
  has_many :comments, as: :commentable

  def Post.sort
    sorted_posts = self.all.sort_by do |post|
      post.votes.count
    end
    sorted_posts.reverse
  end

  def points
    age_in_hours = (Time.now - self.created_at) / 3600 + 1
    points = (self.votes.count / age_in_hours).round(1)
  end
end