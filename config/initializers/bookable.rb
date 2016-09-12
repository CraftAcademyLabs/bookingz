ActsAsBookable::Booking.class_eval do
  validate :client_cannot_be_empty

  def client_cannot_be_empty
    errors.add(:client, 'can\'t be empty') if client.nil? || client.empty?
  end

end
