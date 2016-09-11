ActsAsBookable::Booking.class_eval do

  validate :booking_date_cannot_be_in_the_past

  def booking_date_cannot_be_in_the_past
    errors.add(:time_start, 'can\'t be in the past') if time_start < Date.today
  end

end
