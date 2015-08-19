require 'rails_helper'

describe 'Static pages' do

  subject { page }

  shared_examples_for 'all static pages' do
    it { expect(page).to have_selector('h1', text: heading) }
    it { expect(page).to have_title(page.title) }
  end

  describe 'Home page' do
    let(:heading) { 'Amaterasu' }
    let(:page_title) { '' }

    before { visit root_path }

    it_should_behave_like 'all static pages'
    it { expect(page).to_not have_title('| Home') }

    describe 'for logged-in users' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        FactoryGirl.create(:micropost, user: user, content: 'First content.')
        FactoryGirl.create(:micropost, user: user, content: 'Last content.')

        visit '/en/signin'
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log in'

        visit root_path
      end

      it 'renders the user\'s feed' do
        user.feed.each do |item|
          expect(page).to have_selector('li', text: item.content)
        end
      end

      describe 'follower/following counts' do
        let(:other_user) { FactoryGirl.create(:user) }

        before do
          visit '/en/signin'
          fill_in 'Email', with: user.email.upcase
          fill_in 'Password', with: user.password
          click_button 'Log in'

          other_user.follow(user)
          visit root_path
        end

        it { should have_link('You are following 0 users') }
        it { should have_link('Your followers 1 user') }
      end
    end
  end

  describe 'Help page' do
    let(:heading) { 'Help' }
    let(:page_title) { full_title('Help') }

    before { visit '/en/help' }

    it_should_behave_like 'all static pages'
  end

  describe 'About page' do
    let(:heading) { 'About Us' }
    let(:page_title) { full_title('About Us') }

    before { visit '/en/about' }

    it_should_behave_like 'all static pages'
  end

  describe 'Contact page' do
    let(:heading) { 'Contacts' }
    let(:page_title) { full_title('Contacts') }

    before { visit '/en/contact' }

    it_should_behave_like 'all static pages'
  end

  it 'have the right links on the layout' do
    visit root_path

    click_link 'Contacts'
    expect(page).to have_title('Amaterasu | Contacts')
    click_link 'About Us'
    expect(page).to have_title('Amaterasu | About Us')
    click_link 'Help'
    expect(page).to have_title('Amaterasu | Help')
    click_link 'Home'
    expect(page).to have_title('Amaterasu')
    click_link 'Sign up now!'
    expect(page).to have_title('Amaterasu | Sign up')
  end
end
