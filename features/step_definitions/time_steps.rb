Given(/^it is currently (.+)$/) do |time|
  travel_to time
end

Given(/^time is frozen at (.+)$/) do |time|
  page.execute_script("MockDate.set('#{time}'); var date = currentDate(); $('#date').html(date);")
  freeze_time_at time
end

Given(/^(?:I|we) return to the present$/) do
  Timecop.return
end

After do
  Timecop.return
end