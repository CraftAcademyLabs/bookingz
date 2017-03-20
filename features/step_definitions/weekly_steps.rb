Given(/^the application is set up for weekly view$/) do
  Settings.mode = :weekly_view
end

Then(/^the app should be in weekly view$/) do
  expect(Settings.mode).to eq :weekly_view
end

Given(/^the application is set up for "([^"]*)"$/) do |mode|
  Settings.mode = mode.gsub(/( )/, '_').to_sym
end

Then(/^the app should be in "([^"]*)"$/) do |mode|
  expect(Settings.mode).to eq mode.gsub(/( )/, '_').to_sym
end