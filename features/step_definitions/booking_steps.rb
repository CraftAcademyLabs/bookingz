And(/^the following bookings exist$/) do |table|
  table.hashes.each do |booking|
    start_time = Time.zone.parse([booking[:date], booking[:start_time]].join(' '))
    end_time = Time.zone.parse([booking[:date], booking[:end_time]].join(' '))
    booker = User.first #We have only one user
    resource = Resource.find_by(designation: booking[:resource])
    if start_time.is_a?(ActiveSupport::TimeWithZone) && end_time.is_a?(ActiveSupport::TimeWithZone)
      booker.book!(resource, time_start: start_time, time_end: end_time, amount: resource.capacity, client: booking[:client])
    end
  end
end

Then(/^there should be "([^"]*)" current bookings for "([^"]*)"$/) do |count, resource|
  @resource = Resource.find_by(designation: resource)
  @bookings = @resource.current_day_bookings(Date.today.to_s)
  expect(@bookings.size).to eq count.to_i
end

And(/^I should see bookings for "([^"]*)"$/) do |resource|
  sleep(0.1) until page.evaluate_script('$.active') == 0
  resource = Resource.find_by(designation: resource)
  @bookings.each do |booking|
    within "#card-#{resource.id}" do
      expect(page).to have_content booking.client
    end
  end

end

Then(/^I should see "([^"]*)" in "([^"]*)" box$/) do |content, resource|
  resource = Resource.find_by(designation: resource)
  within "#card-#{resource.id}" do
    expect(page).to have_content content
  end
end

Then(/^I should see the following content in resource box$/) do |table|
  sleep(0.1) until page.evaluate_script('$.active') == 0

  table.hashes.each do |hash|
    resource = Resource.find_by(designation: hash[:resource])
    within "#card-#{resource.id}" do
      expect(page).to have_content hash[:content]
    end
  end
end

And(/^I click on "([^"]*)" for "([^"]*)"$/) do |slot, resource|
  @resource = Resource.find_by(designation: resource)
  script = "var e = $('#card-#{@resource.id} .content .with-scroll .action').filter('.action:contains(\"#{slot}\")')[0].click();"
  page.execute_script(script)
  sleep(0.1) until page.evaluate_script('$.active') == 0
end

Then(/^I should see a details modal for "([^"]*)" for "([^"]*)"$/) do |arg1, arg2|
  #TODO: This is passing no matter if visible is set to true or false :-()
  expect(page).to have_selector '#slot-modal', visible: true
end

And(/^I scroll down in the "([^"]*)" box$/) do |resource|
  resource = Resource.find_by(designation: resource)
  page.execute_script("$('#card-#{resource.id} .content .with-scroll').scrollTop(1000);")
  sleep(0.1) until page.evaluate_script('$.active') == 0
end

Given(/^I want to make a booking with following settings$/) do |table|
  settings = table.hashes.first
  resource = Resource.find_by(designation: settings[:resource])

  @session = ActionDispatch::Integration::Session.new(Rails.application)
  booking = {resource_id: resource.id,
             booking_date: settings[:date],
             client: settings[:client],
             time_start: settings[:start],
             time_end: settings[:end]}

  @session.post(user_session_path, params: {user: {email: 'admin@random.com', password: 'admin_password', remember_me: '0'}})
  @session.post(create_booking_path(locale: :en), params: {booking: booking})
  @session.follow_redirect!

end

Then(/^I should get "([^"]*)" message$/) do |message|
  expect(@session.response.body).to include message
end