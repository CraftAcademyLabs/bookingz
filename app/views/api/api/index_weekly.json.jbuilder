json.items @resources.each do |resource|
  json.designation resource.designation
  json.uuid resource.uuid
  json.id resource.id
  json.slots do
    slots = create_day_range(end_date: @date)
    json.array! slots do |slot|
        json.info {
          json.id slots.index(slot) + 1
          json.time slot
        }
        json.state 'free'
     # end
    end
  end
end