json.items @resources.each do |restaurant|
  json.id restaurant.id
  json.slots do
    slots = create_hour_range(start_time: 8.hours, end_time: 20.hours)
    json.array! slots do |slot|
      if slot_booked?(restaurant, @date, slot)
        json.info {
          json.id (restaurant.current_day_bookings(@date).to_a.index(@booking) + 1)
          json.time slot
          json.client @booking.client
          json.booking_time [@booking.time_start.to_time.to_formatted_s(:time), @booking.time_end.to_time.to_formatted_s(:time)].join(' - ')
        }
        json.state 'booked'
      else
        json.info id: slots.index(slot), time: slot
        json.state 'free'
      end
    end
  end
end


