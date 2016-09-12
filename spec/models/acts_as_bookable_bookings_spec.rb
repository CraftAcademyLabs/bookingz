require 'rails_helper'

describe ActsAsBookable::Booking, type: :model do
  it{is_expected.to respond_to :client}
  it{is_expected.to respond_to :time_start}
  it{is_expected.to respond_to :time_end}
  it{is_expected.to respond_to :amount}

  describe 'reject booking if no client' do
    it 'rejects bookings without a client' do
      booking = described_class.create( client: '', time_start: Date.today)
      expect(booking).not_to be_valid
      expect(booking.errors.full_messages).to include 'Client can\'t be empty'
    end
  end
end
