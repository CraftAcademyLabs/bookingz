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

    xit { is_expected.to be_bookable }
    it { is_expected.to respond_to :be_booked! }
    it { is_expected.to respond_to :bookings }
    xit { is_expected.to respond_to :schedule }

    it 'allow to book a bookable resource' do
      expect(subject.be_booked! user).to be_truthy
    end
  end
end
