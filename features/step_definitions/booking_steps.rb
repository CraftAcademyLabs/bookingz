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
  @bookings = @resource.current_day_bookings
  expect(@bookings.size).to eq count.to_i
end

And(/^I should see bookings for "([^"]*)"$/) do |resource|
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
  table.hashes.each do |hash|
    resource = Resource.find_by(designation: hash[:resource])
    within "#card-#{resource.id}" do
      expect(page).to have_content hash[:content]
    end
  end
end

And(/^I click on "([^"]*)" for "([^"]*)"$/) do |slot, resource|
  @resource = Resource.find_by(designation: resource)
  page.evaluate_script("var element = $( '#card-#{@resource.id} .content .action' ).filter(function () {
    return this.innerHTML == '#{slot}';}).css('background-color','red'); element.click();")
end

Then(/^I should see a details modal for "([^"]*)" for "([^"]*)"$/) do |arg1, arg2|
  sleep(0.1) until page.evaluate_script('$.active') == 0
  binding.pry
  expect(page).to have_selector '.reveal-overlay[style="display: block;]"'
end