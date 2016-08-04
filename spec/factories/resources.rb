FactoryGirl.define do
  factory :resource do
    designation 'Room'
    description 'Lorem ipsum...'
    capacity 4
    schedule {
      schedule = IceCube::Schedule.new(Date.today, duration: 1.day)
      schedule.add_recurrence_rule IceCube::Rule.daily
      schedule
    }
  end
end
