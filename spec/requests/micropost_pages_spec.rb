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

  describe 'micropost creation' do
    before { visit root_path }

    describe 'with invalid information' do
      it 'not creates a micropost' do
        expect { click_button 'Post' }.not_to change(Micropost, :count)
      end

      describe 'error messages' do
        before { click_button 'Post' }

        it { should have_content('error') }
      end
    end

    describe 'with valid information' do
      before { fill_in 'micropost_content', with: 'Test content.' }

      it 'creates a micropost' do
        expect { click_button 'Post' }.to change(Micropost, :count).by(1)
      end
    end
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
