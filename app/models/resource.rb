class Resource < ApplicationRecord
  acts_as_bookable time_type: :range,
                   capacity_type: :closed

  validates_presence_of :designation, :uuid

  def current_day_bookings(date)
    self.bookings.select {|booking| booking.time_start.to_date == Date.parse(date)}
  end
end
