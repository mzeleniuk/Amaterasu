require 'rails_helper'

describe 'Micropost pages' do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before do
    visit '/en/signin'
    fill_in 'Email', with: user.email.upcase
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  describe 'micropost destruction' do
    before { FactoryGirl.create(:micropost, user: user) }

    describe 'as correct user' do
      before { visit root_path }

      it 'deletes a micropost' do
        expect { click_link 'Delete' }.to change(Micropost, :count).by(-1)
      end
    end
  end
end
