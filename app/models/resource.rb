class Resource < ApplicationRecord
  acts_as_bookable time_type: :range,
                   capacity_type: :closed,
                   bookable_across_occurrences: true

  validates_presence_of :designation, :uuid, :facility, :direction
  validates_uniqueness_of :uuid

  belongs_to :facility
  DIRECTIONS = %w{left right up down}


  def current_day_bookings(date)
    self.bookings.select {|booking| booking.time_start.to_date == Date.parse(date)}
  end
end
