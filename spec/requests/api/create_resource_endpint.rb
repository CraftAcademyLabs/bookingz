# 123e4567-e89b-12d3-a456-426655440000

require 'rails_helper'

describe Api::ApiController, type: :request do

  it 'creates an object with valid request' do
    post '/api/resources', {params: {resource: {uuid: '123e4567-e89b-12d3-a456-426655440000',
                                                designation: 'New conference room',
                                                capacity: 20}}, headers: {'HTTP_ACCEPT': 'application/json'}}


    new_object = Resource.last
    expected_response = {id: new_object.id,
                         uuid: '123e4567-e89b-12d3-a456-426655440000',
                         designation: 'New conference room'}
    expect(response_json).to eq expected_response.as_json
  end
end