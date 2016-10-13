# 123e4567-e89b-12d3-a456-426655440000

require 'rails_helper'

describe Api::ApiController, type: :request do

  it 'creates an object with valid request' do
    post api_resources_path, {params: {resource: {uuid: '123e4567-e89b-12d3-a456-426655440000',
                                                designation: 'New conference room',
                                                capacity: 20}}, headers: {'HTTP_ACCEPT': 'application/json'}}


    new_object = Resource.last
    expected_response = {id: new_object.id,
                         uuid: '123e4567-e89b-12d3-a456-426655440000',
                         designation: 'New conference room'}
    expect(response_json).to eq expected_response.as_json
  end

  it 'reject object creation on invalid request' do
    post api_resources_path, {params: {resource: {uuid: '123e4567-e89b-12d3-a456-426655440000'}}, headers: {'HTTP_ACCEPT': 'application/json'}}
    expected_error_response = ['Capacity is not a number', 'Capacity can\'t be blank', 'Designation can\'t be blank'].sort
    expect(response_json['message']).to eq expected_error_response
  end


  it 'reject object creation without uuid' do
    post api_resources_path, {params: {resource: {uuid: '',
                                                designation: 'New conference room',
                                                capacity: 20}}, headers: {'HTTP_ACCEPT': 'application/json'}}
    
    expected_error_response = ['Uuid can\'t be blank'].sort
    expect(response_json['message']).to eq expected_error_response
  end

  it 'updates object' do

    object = FactoryGirl.create(:resource, uuid: '123e4567-e89b-12d3-a456-426655440000')
    put '/api/resources/', {params: {resource: {uuid: '123e4567-e89b-12d3-a456-426655440000',
                                                  designation: 'Conference room',
                                                  capacity: 20}}, headers: {'HTTP_ACCEPT': 'application/json'}}
    object = Resource.find_by(uuid: '123e4567-e89b-12d3-a456-426655440000')
    expected_response = {id: object.id,
                         uuid: '123e4567-e89b-12d3-a456-426655440000',
                         designation: 'Conference room'}
    expect(response_json).to eq expected_response.as_json

  end
end