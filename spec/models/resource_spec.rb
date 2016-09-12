require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'Factory' do
    it 'is valid' do
      expect(FactoryGirl.create(:resource)).to be_valid
    end
  end

  describe 'DB table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :designation }
    it { is_expected.to have_db_column :description }
  end

  describe 'bookable methods' do
    subject { FactoryGirl.create(:resource) }
    let(:user) { FactoryGirl.create(:user) }

    #xit { is_expected.to be_bookable }
    it { is_expected.to respond_to :be_booked! }
    it { is_expected.to respond_to :bookings }
    it { is_expected.to respond_to :schedule }
    it { is_expected.to respond_to :capacity }

    context 'valid booking' do
      before do
        @from = Date.today.next_week + 9.hours
        @to = @from + 2.hours
        subject.be_booked! user, client: 'Whoever', time_start: @from, time_end: @to, amount: subject.capacity
      end

      it 'adds booking' do
        expect(subject.bookings.count).to eq 1
      end

      it 'rejects identical booking with ActsAsBookable::AvailabilityError' do
        expect {
          subject.be_booked! user, time_start: @from, time_end: @to, amount: 4
        }.to raise_error(ActsAsBookable::AvailabilityError, 'The room is already booked')
      end

      it 'is of ActsAsBookable::Booking class' do
        expect(subject.bookings.last.class).to eq ActsAsBookable::Booking
      end
    end
  end

  describe 'custom bookable methods' do
    subject { FactoryGirl.create(:resource) }
    let(:user) { FactoryGirl.create(:user) }

    before do
      Timecop.freeze('2016-01-01')
      from = Date.today + 15.hour + 30.minutes
      to = from + 1.hour
      @booking = subject.be_booked! user, client: 'Whoever', time_start: from, time_end: to, amount: 4
    end

    it 'returns a list of today´s bookings' do
      expect(subject.current_day_bookings('2016-01-01')).to include subject.bookings.last
    end

    it 'returns empty list if no bookings exists' do
      Timecop.freeze('2016-01-02')
      expect(subject.current_day_bookings(Date.today.to_s)).not_to include subject.bookings.last
    end

  end
end
