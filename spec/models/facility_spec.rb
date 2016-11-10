require 'rails_helper'

RSpec.describe Facility, type: :model do

  describe 'Factory' do
    it 'is valid' do
      expect(FactoryGirl.create(:facility)).to be_valid
    end
  end

  describe 'DB table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :code }
  end

  describe 'Associations' do
    it { is_expected.to have_many :users }
    it { is_expected.to have_many :resources }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of(:code).is_equal_to(4) }

  end
end
