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
    it { is_expected.to have_db_column :approved }
    it { is_expected.to have_db_column(:superadmin).of_type(:boolean) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :facility }
  end

  describe 'approved methods' do
    it { is_expected.to respond_to :approved }
  end

  describe 'Roles' do
    let(:user_1) { create(:user, superadmin: true) }
    let(:user_2) { create(:user, superadmin: false) }

    it 'user? should respond true if not superadmin' do
      expect(user_2.user?).to be_truthy
    end

    it 'user? should respond false if superadmin' do
      expect(user_1.user?).to be_falsey
    end

    it 'superadmin? should respond true if superadmin' do
      expect(user_1.superadmin?).to be_truthy
    end

    it 'superadmin? should respond true if user' do
      expect(user_2.superadmin?).to be_falsey
    end

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
