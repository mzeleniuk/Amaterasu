Given /^User visits home page$/ do
  visit '/en'
end

Then /^He should see text '(.+)'$/ do |text|
  expect(page).to have_text(text)
end

And /^He should see a '(.+)' link$/ do |text|
  expect(page).to have_link(text)
end

And /^He should see button '(.+)'$/ do |text|
  expect(page).to have_button(text)
end

And /^He clicks on '(.+)' link$/ do |text|
  click_on text
end
