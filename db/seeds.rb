# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

facility = Facility.create(name: 'Craft Academy', address: 'Holtermansgatan 1D, Göteborg')

description = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.
        Fuga, officiis sunt neque facilis culpa molestiae necessitatibus delectus veniam provident.'

Resource.all.each { |r| r.destroy }
Resource.create(designation: 'Lilla konferanssalen 1', description: description, facility: facility, capacity: 8, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))
Resource.create(designation: 'Lilla konferanssalen 2', description: description, facility: facility, capacity: 8, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))
Resource.create(designation: 'Stora konferanssalen', description: description, facility: facility, capacity: 20, uuid: SecureRandom.uuid,
                schedule: IceCube::Schedule.new(Date.today - 1.week, duration: 1.day))


Resource.all.each do |resource|
  resource.schedule.add_recurrence_rule IceCube::Rule.daily
end

User.create(email: 'admin@admin.com', password: 'password', superadmin: true, approved: true)