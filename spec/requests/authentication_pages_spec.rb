require 'rails_helper'

describe 'Authentication' do

  subject { page }

  describe 'Log in page' do
    before { visit '/en/signin' }

    it { expect(page).to have_content('Log in') }
    it { expect(page).to have_title('Amaterasu | Log in') }
  end

  describe 'Log in' do
    before { visit '/en/signin' }

    describe 'with invalid information' do
      before { click_button 'Log in' }

      it { expect(page).to have_title('Amaterasu | Log in') }
      it { expect(page).to have_text('Invalid email/password combination!') }
    end

    describe 'after visiting another page' do
      before {
        click_button 'Log in'
        click_link 'Home'
      }

      it { expect(page).to_not have_text('Invalid email/password combination!') }
    end
  end

  describe 'with valid information' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      visit '/en/signin'
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    it { expect(page).to have_title("Amaterasu | #{user.name}") }
    it { expect(page).to have_link('Account') }
    it { expect(page).to_not have_link('Log in', href: signin_path) }

    describe 'followed by log out' do
      before { click_link 'Account' }

      it { expect(page).to have_link('Log out') }
    end
  end

  describe 'Authorization' do
    describe 'for non-logged-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'in the Users controller' do

        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }

          it { expect(page).to have_title('Amaterasu | Log in') }
          it { expect(page).to have_text('Please log in.') }
        end

        describe 'submitting to the update action' do
          before { patch user_path(user) }

          specify { expect(response).to redirect_to('http://www.example.com/en/signin') }
        end

        describe 'visiting the user index' do
          before { visit users_path }

          it { expect(page).to have_title('Amaterasu | Log in') }
          it { expect(page).to have_text('Please log in.') }
        end

        describe 'visiting the following page' do
          before { visit following_user_path(user) }

          it { expect(page).to have_title('Amaterasu | Log in') }
          it { expect(page).to have_text('Please log in.') }
        end

        describe 'visiting the followers page' do
          before { visit followers_user_path(user) }

          it { expect(page).to have_title('Amaterasu | Log in') }
          it { expect(page).to have_text('Please log in.') }
        end
      end

      describe 'in the Relationships controller' do
        describe 'submitting to the create action' do
          before { post relationships_path }

          specify { expect(response).to redirect_to('http://www.example.com/en/signin') }
        end

        describe 'submitting to the destroy action' do
          before { delete relationship_path(1) }

          specify { expect(response).to redirect_to('http://www.example.com/en/signin') }
        end
      end
    end

    describe 'for non-activated users' do
      let(:user) { FactoryGirl.create(:user, activated: false, activated_at: nil) }

      before do
        visit '/en/signin'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      it 'shows activation reminder' do
        expect(page).to have_text('Account not activated. Check your email for the activation link.')
      end
    end

    describe 'as wrong user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }

      before do
        visit '/en/signin'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end

      describe 'submitting a GET request to the Users#edit action' do
        before { get edit_user_path(wrong_user) }

        specify { expect(response.body).not_to match('Edit user') }
        specify { expect(response).to redirect_to('http://www.example.com/en/signin') }
      end

      describe 'submitting a PATCH request to the Users#update action' do
        before { patch user_path(wrong_user) }

        specify { expect(response).to redirect_to('http://www.example.com/en/signin') }
      end
    end

    describe 'for logged-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'when attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
          click_button 'Log in'
        end

        describe 'after logging in' do
          it 'should render the desired protected page' do
            expect(page).to have_title("Amaterasu | #{user.name}")
          end

          describe 'when signing in again' do
            before do
              click_link 'Account'
              click_link 'Log out'

              visit '/en/signin'
              fill_in 'Email', with: user.email
              fill_in 'Password', with: user.password
              click_button 'Log in'
            end

            it 'renders the default (profile) page' do
              expect(page).to have_title("Amaterasu | #{user.name}")
            end
          end
        end
      end

      describe 'in the Microposts controller' do
        describe 'submitting to the create action' do
          before { post microposts_path }

          specify { expect(response).to redirect_to('http://www.example.com/en/signin') }
        end

        describe 'submitting to the destroy action' do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }

          specify { expect(response).to redirect_to('http://www.example.com/en/signin') }
        end
      end
    end

    describe 'as non-admin user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before do
        visit edit_user_path(user)
        fill_in 'Email', with: non_admin.email
        fill_in 'Password', with: non_admin.password
        click_button 'Log in'
      end

      describe 'submitting a DELETE request to the Users#destroy action' do
        before { delete user_path(user) }

        specify { expect(response).to redirect_to('http://www.example.com/en/signin') }
      end
    end
  end
end
