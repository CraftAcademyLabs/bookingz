Given(/^a facility named "([^"]*)" exists$/) do |name|
  FactoryGirl.create(:facility, name: name)
end

And(/^I select "([^"]*)" from "([^"]*)"$/) do |value, field|
  select value, from: field
end

Then(/^"([^"]*)" should be assigned to "([^"]*)"$/) do |user, facility_name|
  user = User.find_by(email: user)
  facitity = Facility.find_by(name: name)
  expect(user.facility).to be facitity
end