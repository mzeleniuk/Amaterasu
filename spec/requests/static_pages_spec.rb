require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Amaterasu' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Довідка' }
    let(:page_title) { full_title('Довідка') }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'Про нас' }
    let(:page_title) { full_title('Про нас') }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { 'Контакти' }
    let(:page_title) { full_title('Контакти') }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Про нас"
    expect(page).to have_title(full_title('Про нас'))
    click_link "Довідка"
    expect(page).to have_title(full_title('Довідка'))
    click_link "Контакти"
    expect(page).to have_title(full_title('Контакти'))
    click_link "Головна сторінка"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Зареєструватися'))
    click_link "Amaterasu"
    expect(page).to have_title(full_title(''))
  end
end