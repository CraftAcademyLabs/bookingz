FactoryGirl.define do
  factory :resource do
    designation 'Room'
    description 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.
        Fuga, officiis sunt neque facilis culpa molestiae necessitatibus delectus veniam provident.'
    uuid { SecureRandom.uuid }
    capacity 4
    schedule {
      schedule = IceCube::Schedule.new(Date.today - 1.year, duration: 1.year)
      schedule.add_recurrence_rule IceCube::Rule.daily
      schedule
    }
  end
end
