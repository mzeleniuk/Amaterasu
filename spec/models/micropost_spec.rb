require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before { @micropost = user.microposts.build(content: 'Post content') }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe 'when user_id is not present' do
    before { @micropost.user_id = nil }

    it { should_not be_valid }
  end

  describe 'with blank content' do
    before { @micropost.content = '' }

    it { should_not be_valid }
  end
end
