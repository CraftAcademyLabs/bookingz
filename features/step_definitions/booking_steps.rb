And(/^the following bookings exist$/) do |table|
  table.hashes.each do |booking|
    start_time = Time.zone.parse([booking[:date], booking[:start_time]].join(' '))
    end_time = Time.zone.parse([booking[:date], booking[:end_time]].join(' '))
    booker = User.first #We have only one user
    resource = Resource.find_by(designation: booking[:resource])
    if start_time.is_a?(ActiveSupport::TimeWithZone) && end_time.is_a?(ActiveSupport::TimeWithZone)
      booker.book!(resource, time_start: start_time, time_end: end_time, amount: resource.capacity, client: booking[:client] )
    end
  end
end

Then(/^there should be "([^"]*)" bookings in the system$/) do |count|
  expected_count = count.to_i
  expect(ActsAsBookable::Booking.count).to eq expected_count
end