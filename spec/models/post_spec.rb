require 'spec_helper'

describe Post do
  it { should validate_presence_of :description }
  it { should validate_presence_of :link }
  it { should validate_presence_of :user_id }
  it { should ensure_length_of(:description).is_at_most(25) }
  it { should belong_to :user }
  it { should have_many :votes }
  it { should have_many :comments }

  it "sorts posts depending on vote popularity" do
    user1 = User.create!(user_name: 'User1', password: 'test1234', password_confirmation: 'test1234')
    user2 = User.create!(user_name: 'User2', password: 'test1234', password_confirmation: 'test1234')
    post1 = Post.create!(:link => "link", :description => "description", :user_id => 1)
    post2 = Post.create!(:link => "link", :description => "description", :user_id => 2)
    vote1 = Vote.create!(:user_id => 1, :post_id => 2)
    vote2 = Vote.create!(:user_id => 2, :post_id => 2)
    vote3 = Vote.create!(:user_id => 1, :post_id => 1)
    Post.sort.should eq [post2, post1] 
  end

  it "sets the number of 'points' to the number of votes, prior to time passing" do
    post = Post.create(:description => 'Gmail', :link => 'http://www.gmail.com', :user_id => 1)
    vote1 = Vote.create(:user_id => 1, :post_id => post.id)
    vote2 = Vote.create(:user_id => 2, :post_id => post.id)
    vote3 = Vote.create(:user_id => 3, :post_id => post.id)
    vote4 = Vote.create(:user_id => 4, :post_id => post.id)
    vote5 = Vote.create(:user_id => 5, :post_id => post.id)
    post.points.should eq 5
  end

  it "determines the number of points depending on the age in hours" do
    post = Post.create(:description => 'Gmail', :link => 'http://www.gmail.com', :user_id => 1)
    vote1 = Vote.create(:user_id => 1, :post_id => post.id)
    vote2 = Vote.create(:user_id => 2, :post_id => post.id)
    vote3 = Vote.create(:user_id => 3, :post_id => post.id)
    vote4 = Vote.create(:user_id => 4, :post_id => post.id)
    vote5 = Vote.create(:user_id => 5, :post_id => post.id)
    sixtyone_minutes_from_now = Time.now + 61.minutes
    Time.stub(:now).and_return(sixtyone_minutes_from_now)
    post.points.should eq 2.5
  end

  it "determines the number of points depending on the age in hours" do
    post = Post.create(:description => 'Gmail', :link => 'http://www.gmail.com', :user_id => 1)
    vote1 = Vote.create(:user_id => 1, :post_id => post.id)
    vote2 = Vote.create(:user_id => 2, :post_id => post.id)
    vote3 = Vote.create(:user_id => 3, :post_id => post.id)
    vote4 = Vote.create(:user_id => 4, :post_id => post.id)
    vote5 = Vote.create(:user_id => 5, :post_id => post.id)
    vote6 = Vote.create(:user_id => 6, :post_id => post.id)
    onehundredtwentyone_minutes_from_now = Time.now + 121.minutes
    Time.stub(:now).and_return(onehundredtwentyone_minutes_from_now)
    post.points.should eq 2
  end
end