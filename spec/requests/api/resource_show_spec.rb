
#A UUID is a 16-octet (128-bit) number.
# 123e4567-e89b-12d3-a456-426655440000

require 'rails_helper'

describe Api::ApiController, type: :request do

  let!(:resource_1) { FactoryGirl.create(:resource,
                                         uuid: '123e4567-e89b-12d3-a456-426655440000')}
  it 'fetches bookings for a resource' do
    get api_resource_path(resource_1)
  end
end