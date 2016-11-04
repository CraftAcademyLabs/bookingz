Given(/^a facility named "([^"]*)" exists$/) do |name|
  FactoryGirl.create(:facility, name: name)
end

And(/^I select "([^"]*)" from "([^"]*)"$/) do |value, field|
  select value, from: field
end