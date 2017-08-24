require 'rails_helper'

describe Api::ApiController, type: :request do
  Settings.slot_configuration.increment = 30
  Settings.slot_configuration.end_time = 20
  let!(:user) { create(:user, superadmin: true) }
  let!(:facility) { create(:facility, code: 'qwer') }
  let!(:resource) { create(:resource,
                           designation: 'My Room',
                           uuid: '123e4567-e89b-12d3-a456-426655440000',
                           facility: facility) }

  describe 'book current slot - ad hoc booking' do
    it 'allows booking and returns updated feed' do
      Timecop.freeze('2016-01-01')
      from = Date.today + 15.hour + 30.minutes
      to = from + 1.hour
      payload = {params: {time_start: from,
                          time_end: to, amount: 4,
                          client: 'Craft Academy'},
                 headers: {'HTTP_ACCEPT': 'application/json'}}
      expected_response = eval(file_fixture('resource_ad_hoc_booking_response.txt').read)
      post "/api/resources/#{resource.uuid}/create_booking", payload
      expect(response_json).to eq expected_response.as_json
    end
  end
end
