json.items @resources.each do |restaurant|
  json.id restaurant.id
    json.slots do
      slots = create_hour_range(start_time: 8.hours, end_time: 20.hours)
      json.array! slots do |slot|
        if slot_booked?(restaurant, Date.today, slot)
          json.info {
            json.id (restaurant.bookings.to_a.index(@booking) + 1)
            json.time [@booking.time_start.to_time.to_formatted_s(:time), @booking.time_end.to_time.to_formatted_s(:time)].join(' - ')
            json.client @booking.client
          }
          json.state 'booked'
        else
          json.info id: slots.index(slot), time: slot
          json.state 'free'
        end
      end
    end
end


