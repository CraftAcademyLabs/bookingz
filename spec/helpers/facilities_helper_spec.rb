require 'rails_helper'

RSpec.describe FacilitiesHelper, type: :helper do
  describe '#unassigned_users' do
    let!(:user_1) { create(:user, email: 'user_1@facility.com') }
    let!(:user_2) { create(:user, email: 'user_2@facility.com') }
    let!(:user_3) { create(:user, email: 'user_3@facility.com') }
    let!(:superadmin) { create(:user, email: 'superadmin@facility.com', superadmin: true) }

    let!(:facility_1) { create(:facility) }


    before do
      user_1.update_attribute(:facility, facility_1)
    end

    it 'returns a collection of users without a facility' do
      expected_collection = [{id: user_2.id, email: 'user_2@facility.com'}, {id: user_3.id, email: 'user_3@facility.com'}]
      expect(helper.unassigned_users).to match expected_collection
    end
  end


end