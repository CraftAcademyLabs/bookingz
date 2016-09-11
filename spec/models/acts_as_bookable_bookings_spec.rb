require 'rails_helper'

describe ActsAsBookable::Booking, type: :model do
  it{is_expected.to respond_to :client}
  it{is_expected.to respond_to :time_start}
  it{is_expected.to respond_to :time_end}
  it{is_expected.to respond_to :amount}

  it 'rejects bookings with past date as start time' do
    booking = described_class.create( time_start: Date.today - 1.day)
    expect(booking).not_to be_valid
    expect(booking.errors.full_messages).to include 'Time start can\'t be in the past'
  end

end
