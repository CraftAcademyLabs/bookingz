Given(/^a facility named "([^"]*)" exists$/) do |name|
  FactoryGirl.create(:facility, name: name)
end

And(/^the following facilities exists$/) do |table|
  table.hashes.each do |facility|
    FactoryGirl.create(:facility, name: facility[:name])
  end
end

And(/^I select "([^"]*)" from "([^"]*)"$/) do |value, field|
  find('div.select-wrapper input').click
  find('div.select-wrapper li', text: value).click
end


Then(/^"([^"]*)" should be assigned to "([^"]*)"$/) do |email, facility_name|
  user = User.find_by(email: email)
  facility = Facility.find_by(name: facility_name)
  expect(user.facility).to eq facility
end

And(/^I assign "([^"]*)" to "([^"]*)"$/) do |user, facility_name|
  user = User.find_by(email: user)
  facility = Facility.find_by(name: facility_name)
  user.update_attribute(:facility, facility)
end


Then(/^I should be on the show page for "([^"]*)"$/) do |name|
  facility = Facility.find_by(name: name)
  expect(page.current_path).to eq facility_path(facility, locale: I18n.locale)
end

Then(/^I (should|should not) see "([^"]*)" in a section for "([^"]*)"$/) do |negation, content, facility|
  facility = Facility.find_by(name: facility)
  within "#facility_#{facility.id}" do
    case negation
      when 'should'
        expect(page).to have_content content
      when 'should not'
        expect(page).not_to have_content content
    end
  end
end

And(/^I attach file "([^"]*)"$/) do |file_name|
  page.execute_script('$("#attachment").css("opacity", 1);')
  page.attach_file('facility[attachment]', Rails.root + "spec/fixtures/#{file_name}")
end

And(/^"([^"]*)" should have an file attached to it$/) do |name|
  facility = Facility.find_by(name: name)
  expect(facility.attachment).not_to eq nil
end