# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

description = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.
        Fuga, officiis sunt neque facilis culpa molestiae necessitatibus delectus veniam provident.'

Resource.all.each { |r| r.destroy }
Resource.create(designation: 'Lilla konferanssalen 1', description: description, capacity: 8, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))
Resource.create(designation: 'Lilla konferanssalen 2', description: description, capacity: 8, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))
Resource.create(designation: 'Stora konferanssalen 1', description: description, capacity: 20, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))
Resource.create(designation: 'Stora konferanssalen 2', description: description, capacity: 20, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))
Resource.create(designation: 'Stora kongresshallen', description: description, capacity: 200, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))
Resource.create(designation: 'Lilla kongresshallen', description: description, capacity: 100, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))

Resource.all.each do |resource|
  resource.schedule.add_recurrence_rule IceCube::Rule.daily
end

User.create(email: 'admin@admin.com', password: 'password', superadmin: true, approved: true)