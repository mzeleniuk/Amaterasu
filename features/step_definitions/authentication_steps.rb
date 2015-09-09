Given /^User visits the log in page$/ do
  visit '/en/signin'
end

When /^He submit invalid log in information$/ do
  click_button 'Log in'
end

Then /^He should see an error message$/ do
  expect(page).to have_text('Invalid email/password combination!')
end

And /^User has an account$/ do
  @user = User.create(first_name: 'Example', last_name: 'User', email: 'user@example.com',
                      password: 'foobar', password_confirmation: 'foobar', activated: true)
end

When /^User submits valid log in information$/ do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

Then /^He should see his profile page$/ do
  expect(page).to have_title(@user.full_name)
end

Then /^He should see a log out link$/ do
  click_link 'Account'
  expect(page).to have_link('Log out')
end
