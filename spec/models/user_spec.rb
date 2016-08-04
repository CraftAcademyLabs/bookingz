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
    it { is_expected.to be_booker }
    it { is_expected.to respond_to :book! }
    it { is_expected.to respond_to :bookings }

    let(:booker) { FactoryGirl.create(:user) }
    let(:resource) { FactoryGirl.create(:resource) }

    it 'allow to book a bookable resource' do
      expect(booker.book! resource).to be_truthy
    end
  end

end
