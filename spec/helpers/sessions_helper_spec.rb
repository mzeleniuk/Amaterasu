require 'rails_helper'

describe SessionsHelper, type: :helper do
  describe '#remember' do
    let(:user) { create :user }

    it 'current_user returns nil when remember digest is wrong' do
      remember(user)
      user.update_attribute(:remember_digest, User.digest(User.new_token))

      expect(current_user).to eq(nil)
    end

    it 'current_user returns right user' do
      remember(user)

      expect(user).to eq(current_user)
      expect(signed_in?).to eq(true)
    end
  end
end
