start_time ||= Settings.slot_configuration.start_time.to_i
end_time ||= Settings.slot_configuration.end_time.to_i

json.designation @resource.designation
json.uuid @resource.uuid
json.id @resource.id
json.slots do
  slots = create_hour_range(start_time: start_time.hours, end_time: end_time.hours)
  json.array! slots do |slot|
    if slot_booking(@resource, @date, slot)
      json.info {
        json.id (@resource.current_day_bookings(@date).to_a.index(@booking) + 1)
        json.time slot
        json.client @booking.client
        json.booking_time [@booking.time_start.to_time.to_formatted_s(:time), @booking.time_end.to_time.to_formatted_s(:time)].join(' - ')
      }
      json.state 'booked'
    else
      json.info  time: slot
      json.state 'free'
    end
  end
end
