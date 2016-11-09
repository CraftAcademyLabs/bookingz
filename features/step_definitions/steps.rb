Given(/^the following (?:account|accounts) (?:is|are) configured$/) do |table|
  table.hashes.each do |user|
    FactoryGirl.create(:user, user.merge!(approved: true))
  end
end

Given(/^I am logged out$/) do
  logout
end

Given(/^I am logged in as "([^"]*)"$/) do |value|
  user = User.find_by(email: value, approved: true)
  if user.nil?
    user = FactoryGirl.create(:user, email: value, superadmin: false)
  end
  login_as(user, scope: :user)
end

Given(/^I am logged in as superadmin "([^"]*)"$/) do |value|
  user = FactoryGirl.create(:user, email: value, superadmin: true)
  login_as(user, scope: :user)
end

Given(/^I register a new user$/) do
  steps %q{
    Then I fill in "user[email]" with "test@test.com"
    And I fill in "user[password]" with "password"
    And I fill in "user[password_confirmation]" with "password"
    And I click "Sign up" button
  }
end

Given(/^I attempt to login$/) do
  steps %q{
    Then I fill in "user[email]" with "test@test.com"
    And I fill in "user[password]" with "password"
    And I click "Sign in" button
  }
end

Given(/^the following resources exist$/) do |table|
  table.hashes.each do |resource|
    FactoryGirl.create(:resource, resource)
  end
end


And(/^I (?:am on|navigate to) the "([^"]*)" page$/) do |page|
  locale = I18n.locale
  case page.downcase
    when 'landing' then
      visit root_path(locale: locale)
    when 'instructions' then
      visit page_path('instructions', locale: locale)
    when 'sign up' then
      visit new_user_registration_path(locale: locale)
    when 'forgot your password' then
      visit new_user_password_path(locale: locale)
    when 'login' then
      visit new_user_session_path(locale: locale)
    when 'users' then
      visit approvals_users_path(locale: locale)
    when 'new facility' then
      visit new_facility_path(locale: locale)
    when 'facilities index' then
      visit facilities_path(locale: locale)
  end
end

Then(/^I should be on the "([^"]*)" page$/) do |path|
  locale = I18n.locale
  case path.downcase
    when 'login' then
      expected_path = new_user_session_path(locale: locale)
    when 'instructions' then
      expected_path = page_path(:instructions, locale: locale)
    when 'ca labs' then
      expected_path = page_path(:ca_labs, locale: locale)
    when 'sign up' then
      expected_path = new_user_registration_path(locale: locale)
    when 'Forgot your password' then
      expected_path = new_user_password_path(locale: locale)
    when 'users' then
      expected_path = approvals_users_path(locale: locale)
    when 'landing' then
      expected_path = root_path(locale: locale)
    when 'new facility' then
      expected_path = new_facility_path(locale: locale)
    when 'facilities index' then
      expected_path = facilities_path(locale: locale)
  end

  expect(page.current_path).to eq expected_path
end

And(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content content
end

Then(/^I should not see "([^"]*)"$/) do |content|
  expect(page).not_to have_content content
end

And(/^I should "([^"]*)" see "([^"]*)"$/) do |count, content|
  expect(page).not_to have_content content, count: count.to_i
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

  page.execute_script(mock_date_script(time))
  steps %q{
    And I click arrow "previous"
    And I click arrow "next"
  }

  sleep(0.1) until page.evaluate_script('$.active') == 0
end

Given(/^I click on "([^"]*)"$/) do |element|
  click_link_or_button element
  #sleep(0.1) until page.evaluate_script('$.active') == 0

end

And(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

And(/^I click "([^"]*)"$/) do |value|
  find_button(value).trigger('click')
end

And(/^I click arrow "([^"]*)"$/) do |id|
  find("##{id}").trigger('click')
  sleep(0.1) until page.evaluate_script('$.active') == 0
end

Then(/^I should see "([^"]*)" button$/) do |button|
  expect(page).to have_button button
end

Then(/^I should see "([^"]*)" link$/) do |link|
  expect(page).to have_link link
end

Then(/^I click "([^"]*)" button$/) do |button|
  click_link_or_button button
end


And(/^I should see button "([^"]*)"$/) do |text|
  expect(page).to have_button text
end

private

def mock_date_script(time)
  if Settings.mode == :weekly_view
    "MockDate.set('#{time}');\
     var date = Date.parse(currentDate());\
     $('#date').html(weekOf(date));"
  else
    "MockDate.set('#{time}'); var date = currentDate(); $('#date').html(date);"
  end
end


