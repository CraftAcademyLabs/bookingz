Given(/^it is currently (.+)$/) do |time|
  travel_to time
end

Given(/^time is frozen at (.+)$/) do |time|
  freeze_time_at time
end

Given(/^(?:I|we) jump in our Delorean and return to the present$/) do
  Timecop.return
end


After do
  Timecop.return
end