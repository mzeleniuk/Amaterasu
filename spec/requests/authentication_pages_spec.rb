require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Вхід') }
    it { should have_title('Вхід') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Увійти" }

      it { should have_title('Вхід') }
      it { should have_selector('div.alert.alert-error') }
    end

    describe "after visiting another page" do
      before { click_link "Головна сторінка" }
      it { should_not have_selector('div.alert.alert-error') }
    end
  end

  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      fill_in "Електронна пошта",    with: user.email.upcase
      fill_in "Пароль", with: user.password
      click_button "Увійти"
    end

    it { should have_title(user.name) }
    it { should have_link('Профіль',     href: user_path(user)) }
    it { should have_link('Вийти',    href: signout_path) }
    it { should_not have_link('Увійти', href: signin_path) }

    describe "followed by signout" do
      before { click_link "Вийти" }
      it { should have_link('Вийти') }
    end
  end
end