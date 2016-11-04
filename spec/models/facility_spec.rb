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
  end

  describe 'Associations' do
    it { is_expected.to have_many :users }
  end
end
