Given(/^there are no pending approval requests$/) do
  User.where(approved: false).each do |user|
    user.destroy
  end
end

Given(/^I click on "([^"]*)" for user "([^"]*)"$/) do |value, email|
  user = User.find_by(email: email)
  within "#row-#{user.id}" do
    click_link_or_button value
  end
end

Given(/^the following user is pending approval$/) do |table|
  table.hashes.each do |user|
    FactoryGirl.create(:user, user.merge(approved: false))
  end
end
