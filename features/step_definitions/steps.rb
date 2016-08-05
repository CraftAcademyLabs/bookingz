Given(/^the following admin account is configured$/) do |table|
  # table is a table.hashes.keys # => [:email, :password]
  table.hashes.each do |user|
    FactoryGirl.create(:user, user)
    end
end

Given(/^I am logged in as "([^"]*)"$/) do |value|
  user = User.find_by(email: value)
  login_as(user, scope: :user)
end



Given(/^the following resources exist$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |resource|
    FactoryGirl.create(:resource, resource)
  end
end


And(/^I navigate to the "([^"]*)" page$/) do |page|
  case page
    when 'landing' then
      visit root_path
  end
end

Then(/^I should be on the "([^"]*)" page$/) do |path|
  case path
    when 'login' then
      expected_path = new_user_session_path
  end

  expect(page.current_path).to eq expected_path
end

And(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content content
end

Then(/^show me the page$/) do
  save_and_open_page
end

Then(/^show me an image of the page$/) do
  screenshot_and_open_image
end