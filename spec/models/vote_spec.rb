require 'spec_helper'

describe Vote do
  it { should validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  it { should belong_to :post }
  it { should belong_to :user }
end