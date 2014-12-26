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