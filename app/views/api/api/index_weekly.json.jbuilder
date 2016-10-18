json.items @resources.each do |resource|
  json.designation resource.designation
  json.uuid resource.uuid
  json.id resource.id
  json.slots do
    slots = create_day_range(end_date: @date)
    json.array! slots do |slot|
      # if slot_booking(resource, @date, slot)
      #   json.info {
      #     json.id slots.index(slot) + 1
      #     json.time slot
      #     json.client @booking.client
      #     json.booking_time [@booking.time_start.to_time.to_formatted_s(:time), @booking.time_end.to_time.to_formatted_s(:time)].join(' - ')
      #   }
      #   json.state 'booked'
      # else
        json.info {
          json.id slots.index(slot) + 1
          json.time slot
        }
        json.state 'free'
     # end
    end
  end
end