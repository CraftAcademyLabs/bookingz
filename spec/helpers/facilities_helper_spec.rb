require 'rails_helper'

RSpec.describe FacilitiesHelper, type: :helper do
  describe '#unassigned_users_select_options' do
    let!(:user_1) { create(:user, email: 'user_1@facility.com') }
    let!(:user_2) { create(:user, email: 'user_2@facility.com') }
    let!(:user_3) { create(:user, email: 'user_3@facility.com') }
    let!(:superadmin) { create(:user, email: 'superadmin@facility.com', superadmin: true) }

    let!(:facility_1) { create(:facility) }


    before do
      user_1.update_attribute(:facility, facility_1)
    end

    it 'returns select options of users without a facility' do
      expected_collection = [['user_2@facility.com', user_2.id], ['user_3@facility.com', user_3.id]].sort
      expect(helper.unassigned_users_select_options.sort).to match expected_collection
    end
  end

end