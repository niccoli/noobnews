require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should have_many :posts }
  it { should have_many :votes }
  it { should have_many :comments }

  it "should not allow duplicate usernames" do
    user1 = User.create(:user_name => "jim", :password => "green", :password_confirmation => "green")
    user2 = User.new(:user_name => "jim", :password => "green", :password_confirmation => "green")
    user2.valid?.should eq false
  end

end