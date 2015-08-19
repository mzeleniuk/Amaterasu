require 'rails_helper'

describe 'User pages' do

  subject { page }

  describe 'index' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit '/en/signin'
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log in'

      visit users_path
    end

    it { expect(page).to have_title('Amaterasu | All users') }
    it { expect(page).to have_content('All users') }

    describe 'pagination' do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it 'lists each user' do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe 'delete links' do
      it { expect(page).to_not have_link('Delete') }

      describe 'as an admin user' do
        let(:admin) { FactoryGirl.create(:admin) }

        before do
          visit '/en/signin'
          fill_in 'Email', with: admin.email.upcase
          fill_in 'Password', with: admin.password
          click_button 'Log in'

          visit users_path
        end

        it { expect(page).to have_link('Delete') }

        it 'is be able to delete another user' do
          expect do
            click_link('Delete', match: :first)
          end.to change(User, :count).by(-1)
        end

        it { expect(page).to_not have_link('Delete', href: user_path(admin)) }
      end
    end
  end

  describe 'Sign up page' do

    before { visit '/en/signup' }

    let(:submit) { 'Create my account' }

    describe 'with invalid information' do
      it 'does not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'User name', with: 'Example User'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'foobar'
        fill_in 'Confirm password', with: 'foobar'
      end

      it 'creates a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

    describe 'after submission' do
      before { click_button submit }

      it { expect(page).to have_title('Amaterasu | Sign up') }
      it { expect(page).to have_content('error') }
    end
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      visit '/en/signin'
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    it { expect(page).to have_content(user.name) }
    it { expect(page).to have_title(user.name) }

    describe 'follow/unfollow buttons' do
      let(:other_user) { FactoryGirl.create(:user) }

      before do
        visit '/en/signin'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      describe 'following a user' do
        before { visit user_path(other_user) }

        it 'increments the followed user count' do
          expect do
            click_button 'Follow'
          end.to change(user.following, :count).by(1)
        end

        it 'increments the other user\'s followers count' do
          expect do
            click_button 'Follow'
          end.to change(other_user.followers, :count).by(1)
        end

        describe 'toggling the button' do
          before { click_button 'Follow' }

          it { expect(page).to have_xpath("//input[@value='Unfollow']") }
        end
      end

      describe 'unfollowing a user' do
        before do
          user.follow(other_user)
          visit user_path(other_user)
        end

        it 'decrements the followed user count' do
          expect do
            click_button 'Unfollow'
          end.to change(user.following, :count).by(-1)
        end

        it 'decrements the other user\'s followers count' do
          expect do
            click_button 'Unfollow'
          end.to change(other_user.followers, :count).by(-1)
        end

        describe 'toggling the button' do
          before { click_button 'Unfollow' }

          it { expect(page).to have_xpath("//input[@value='Follow']") }
        end
      end
    end
  end

  describe 'edit' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      visit '/en/signin'
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log in'

      visit edit_user_path(user)
    end

    describe 'page' do
      it { should have_content('Update your profile') }
      it { should have_title('Edit user') }
    end

    describe 'with invalid information' do
      before { click_button 'Update profile' }

      it { should have_content('error') }
    end

    describe 'forbidden attributes' do
      let(:params) do
        {user: {admin: true, password: user.password,
                password_confirmation: user.password}}
      end

      before do
        visit '/en/signin'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'

        patch user_path(user), params
      end

      specify { expect(user.reload).to_not be_admin }
    end
  end

  describe 'with valid information' do
    let(:user) { FactoryGirl.create(:user) }
    let(:new_name) { 'New Name' }
    let(:new_email) { 'new@example.com' }

    before do
      visit '/en/signin'
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log in'

      visit edit_user_path(user)

      fill_in 'User name', with: new_name
      fill_in 'Email', with: new_email
      fill_in 'Your current password', with: user.password
      click_button 'Update profile'
    end

    it { should have_title(new_name) }
    it { should have_selector('div.alert.alert-success') }
    it { should have_link('Account') }

    specify { expect(user.reload.name).to eq new_name }
    specify { expect(user.reload.email).to eq new_email }
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: 'Foo') }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: 'Bar') }

    before do
      visit '/en/signin'
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log in'

      visit user_path(user)
    end

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe 'microposts' do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end

  describe 'following/followers' do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    before { user.follow(other_user) }

    describe 'followed users' do
      before do
        visit '/en/signin'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'

        visit following_user_path(user)
      end

      it { should have_title('Following') }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name) }
    end

    describe 'followers' do
      before do
        visit '/en/signin'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'

        visit followers_user_path(other_user)
      end

      it { should have_title('Followers') }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name) }
    end
  end
end
