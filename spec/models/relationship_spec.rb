require 'rails_helper'

RSpec.describe Relationship, :type => :model do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.active_relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe 'follower methods' do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
  end

  describe 'when followed id is not present' do
    before { relationship.followed_id = nil }

    it { should_not be_valid }
  end

  describe 'when follower id is not present' do
    before { relationship.follower_id = nil }

    it { should_not be_valid }
  end
end
