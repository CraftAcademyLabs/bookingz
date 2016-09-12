require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Factory' do
    it 'is valid' do
      expect(FactoryGirl.create(:user)).to be_valid
    end
  end

  describe 'DB table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :encrypted_password }
  end

  describe 'bookable methods' do
    subject { FactoryGirl.create(:user) }
    let(:resource) { FactoryGirl.create(:resource) }

    it { is_expected.to be_booker }
    it { is_expected.to respond_to :book! }
    it { is_expected.to respond_to :bookings }

    context 'valid booking' do
      before do
        from = Date.today.next_week + 9.hours
        to = from + 2.hours
        subject.book! resource, client: 'Whoever', time_start: from, time_end: to, amount: 4
      end

      it 'adds booking' do
        expect(subject.bookings.count).to eq 1
      end

      it 'is of ActsAsBookable::Booking class' do
        expect(subject.bookings.last.class).to eq ActsAsBookable::Booking
      end
    end

  end

end
