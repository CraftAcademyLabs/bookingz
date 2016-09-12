ActsAsBookable::Booking.class_eval do

  validate :booking_date_cannot_be_in_the_past
  validate :client_cannot_be_empty

  def booking_date_cannot_be_in_the_past
    errors.add(:time_start, 'can\'t be in the past') if time_start < Date.today
  end

  def client_cannot_be_empty
    errors.add(:client, 'can\'t be empty') if client.nil? || client.empty?
  end

end
