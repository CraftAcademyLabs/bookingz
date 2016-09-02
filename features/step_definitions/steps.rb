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
    when 'Instructions' then
      visit page_path('instructions')
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

Then(/^I should not see "([^"]*)"$/) do |content|
  expect(page).not_to have_content content

end

Then(/^show me the page$/) do
  save_and_open_page
end

Then(/^show me an image of the page$/) do
  sleep(0.1) until page.evaluate_script('$.active') == 0
  Capybara::Screenshot.screenshot_and_open_image
end

Given(/^I am using the dashboard on "([^"]*)"$/) do |time|
  steps %q{
      Given I am logged in as "admin@random.com"
      And I navigate to the "landing" page
        }
  page.execute_script("MockDate.set('#{time}'); var date = currentDate(); $('#date').html(date);")
end

Given(/^I click on "([^"]*)"$/) do |element|
  click_link_or_button element
  sleep(0.1) until page.evaluate_script('$.active') == 0

end


And(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

And(/^I click "([^"]*)"$/) do |value|
  find_button(value).trigger('click')
end
