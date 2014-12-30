def full_title(page_title)
  base_title = "Amaterasu"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

include ApplicationHelper

def valid_signin(user)
  fill_in "Електронна пошта",    with: user.email
  fill_in "Пароль", with: user.password
  click_button "Увійти"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Електронна пошта",    with: user.email
    fill_in "Пароль", with: user.password
    click_button "Увійти"
  end
end