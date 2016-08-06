class Resource < ApplicationRecord
  acts_as_bookable time_type: :range,
                   capacity_type: :open

  def current_day_bookings
    self.bookings.select {|booking| booking.time_start.to_date == Date.today}
  end
end
