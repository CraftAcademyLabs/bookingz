json.items @resources.each do |restaurant|
  json.id restaurant.id
  if restaurant.bookings.any?
    json.slots do
      json.array! restaurant.bookings do |booking, i|
        #binding.pry
        json.info {
          json.id (restaurant.bookings.to_a.index(booking) + 1)
          json.time [booking.time_start.to_time.to_formatted_s(:time), booking.time_end.to_time.to_formatted_s(:time)].join(' - ')
          json.client booking.client }
        json.state 'booked'
      end
    end
  else
    json.slots do
      slots = create_hour_range(start_time: 8.hours, end_time: 20.hours)
      json.array! slots do |slot|
        json.info id: slots.index(slot), time: slot
      end
      # json.array! [{info: {id: 1, time: '08:00 - 08:30'}, state: 'free'},
      #              {info: {id: 2, time: '08:30 - 09:00'}, state: 'free'},
      #              {info: {id: 3, time: '09:00 - 09:30'}, state: 'free'}]
    end
  end


end
# slots = create_hour_range(start_time: 8.hours, end_time: 20.hours)
# str = '08:00 - 08:30'
# slot_start, slot_end, *tmp = str.split(' - ')
# (DateTime.parse(slot_start)..DateTime.parse(slot_end)).cover?(booking.time_start.to_datetime)
#if restaurant.bookings.any?

# else
# json.slots [
#                {info: {id: 1, time: '08.00 - 08.30'}, state: 'free'},
#                {info: {id: 2, time: '08.30 - 09.00'}, state: 'free'},
#                {info: {id: 3, time: '09.00 - 09.30', client: 'Volvo'}, state: 'booked'}
#            ]
# end

#binding.pry
#end


# {
#     date: '2016-08-31',
#     items: [
#         {
#             id: 28,
#             slots: [
#                 {info: {id: 1, time: '08.00 - 08.30'}, state: 'free'},
#                 {info: {id: 2, time: '08.30 - 09.00'}, state: 'free'},
#                 {info: {id: 3, time: '09.00 - 09.30', client: 'Volvo'}, state: 'booked'}]
#         },
#         {
#             id: 29,
#             slots: [
#                 {info: {id: 1, time: '08.00 - 08.30'}, state: 'free'},
#                 {info: {id: 2, time: '08.30 - 09.00', client: 'CraftAcademy'}, state: 'booked'},
#                 {info: {id: 3, time: '09.00 - 09.30'}, state: 'free'}]
#         },
#         {
#             id: 30,
#             slots: [
#                 {info: {id: 1, time: '08.00 - 08.30'}, state: 'free'},
#                 {info: {id: 2, time: '08.30 - 09.00', client: 'CraftAcademy'}, state: 'booked'},
#                 {info: {id: 3, time: '09.00 - 09.30'}, state: 'free'}]
#         }]
#
# }