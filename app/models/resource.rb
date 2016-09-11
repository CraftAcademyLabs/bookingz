class Resource < ApplicationRecord
  acts_as_bookable time_type: :range,
                   capacity_type: :closed

 def start_date_cannot_be_in_the_past
   if self.bookings.present? && expiration_date < Date.today
     errors.add(:expiration_date, "Can't book a room in the past")
   end
 end

 def current_day_bookings(date)
   self.bookings.select {|booking| booking.time_start.to_date == Date.parse(date)}
 end

end
