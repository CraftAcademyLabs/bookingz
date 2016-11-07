Given(/^a facility named "([^"]*)" exists$/) do |name|
  FactoryGirl.create(:facility, name: name)
end

And(/^I select "([^"]*)" from "([^"]*)"$/) do |value, field|
  select value, from: field
end

Then(/^"([^"]*)" should be assigned to "([^"]*)"$/) do |email, facility_name|
  user = User.find_by(email: email)
  facility = Facility.find_by(name: facility_name)
  expect(user.facility).to eq facility
end

And(/^I assign "([^"]*)" to "([^"]*)"$/) do |user, facility_name|
  user = User.find_by(email: user)
  within "#row-#{user.id}" do
    select facility_name, from: 'facility_id'
    click_button 'Add'
  end
end