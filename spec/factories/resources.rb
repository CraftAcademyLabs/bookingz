FactoryGirl.define do
  factory :resource do
    designation 'Room'
    description 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.
        Fuga, officiis sunt neque facilis culpa molestiae necessitatibus delectus veniam provident.'
    capacity 4
    schedule {
      schedule = IceCube::Schedule.new(Date.today, duration: 1.day)
      schedule.add_recurrence_rule IceCube::Rule.daily
      schedule
    }
  end
end
