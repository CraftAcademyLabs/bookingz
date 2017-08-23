# 123e4567-e89b-12d3-a456-426655440000

require 'rails_helper'

describe Api::ApiController, type: :request do
  Settings.slot_configuration.increment = 30
  Settings.slot_configuration.end_time = 20

  describe 'create resource endpoint' do
    let!(:facility) { create(:facility, code: 'qwer') }

    it 'creates an object with valid request' do
      payload = {
          params: {
              resource: {
                  uuid: '123e4567-e89b-12d3-a456-426655440000',
                  f_code: facility.code,
                  designation: 'New conference room',
                  capacity: 20,
                  direction: 'left'
              }
          }, headers: {'HTTP_ACCEPT': 'application/json'}
      }

      post api_resources_path, payload

      new_object = Resource.last
      expected_response = {
          id: new_object.id,
          uuid: '123e4567-e89b-12d3-a456-426655440000',
          designation: 'New conference room'
      }
      expect(response_json).to eq expected_response.as_json
    end

    it 'reject object creation without facility' do
      payload = {
          params: {
              resource: {
                  uuid: '123e4567-e89b-12d3-a456-426655440000',
                  f_code: '',
                  designation: 'New conference room',
                  capacity: 20,
                  direction: 'left'
              }
          }, headers: {'HTTP_ACCEPT': 'application/json'}
      }

      post api_resources_path, payload

      expected_error_response = ['Facility can\'t be blank'].sort
      expect(response_json['message']).to eq expected_error_response
    end

    it 'reject object creation on invalid request' do
      payload = {
          params: {resource: {uuid: '123e4567-e89b-12d3-a456-426655440000'}},
          headers: {'HTTP_ACCEPT': 'application/json'}
      }

      post api_resources_path, payload

      expected_error_response = [
          'Capacity is not a number',
          'Capacity can\'t be blank',
          'Designation can\'t be blank',
          'Facility can\'t be blank'
      # "Direction can't be blank"
      ].sort

      expect(response_json['message']).to eq expected_error_response
    end


    it 'reject object creation without uuid' do
      payload = {
          params: {
              resource: {
                  uuid: '',
                  f_code: facility.code,
                  designation: 'New conference room',
                  capacity: 20,
                  direction: 'left'
              }
          }, headers: {'HTTP_ACCEPT': 'application/json'}
      }

      post api_resources_path, payload

      expected_error_response = ['Uuid can\'t be blank'].sort
      expect(response_json['message']).to eq expected_error_response
    end

    it 'updates object' do
      object = create(:resource, uuid: '123e4567-e89b-12d3-a456-426655440000')

      payload = {
          params: {
              uuid: object.uuid,
              resource: {
                  uuid: '123e4567-e89b-12d3-a456-426655440000',
                  designation: 'Conference room',
                  capacity: 20,
                  direction: 'left'
              }
          }, headers: {'HTTP_ACCEPT': 'application/json'}
      }

      put '/api/resources/', payload

      object = Resource.find_by(uuid: '123e4567-e89b-12d3-a456-426655440000')
      expected_response = {
          id: object.id,
          uuid: '123e4567-e89b-12d3-a456-426655440000',
          designation: 'Conference room'
      }

      expect(response_json).to eq expected_response.as_json
    end
  end

  describe 'resource show' do

    let!(:resource_1) { create(:resource,
                               designation: 'My Room',
                               uuid: '123e4567-e89b-12d3-a456-426655440000') }

    let(:user) { create(:user) }

    before do
      Timecop.freeze('2016-01-01')
      from = Date.today + 15.hour + 30.minutes
      to = from + 1.hour
      @booking = resource_1.be_booked! user, time_start: from, time_end: to, amount: 4, client: 'Craft Academy'
    end

    it 'fetches bookings for a resource' do
      expected_response = eval(file_fixture('resource_show.txt').read)
      get show_api_resources_path(uuid: resource_1.uuid), headers: {'HTTP_ACCEPT': 'application/json'}
      expect(response_json).to eq expected_response.as_json
    end

  end
  describe 'resources index endpoint' do
    let!(:resource_1) { create(:resource) }
    let!(:resource_2) { create(:resource) }
    let(:user) { create(:user) }

    before do
      Timecop.freeze('2016-01-01')
      from = Date.today + 15.hour + 30.minutes
      to = from + 1.hour
      @booking = resource_1.be_booked! user,
                                       time_start: from,
                                       time_end: to, amount: 4,
                                       client: 'Craft Academy'
    end

    it 'lists bookings for resource' do
      expected_response = eval(file_fixture('resource_index.txt').read)
      get api_resources_path, headers: {'HTTP_ACCEPT': 'application/json'}
      expect(response_json['items'][0]).to eq expected_response[:items][0].as_json
      expect(response_json['items'][1]['designation']).to eq resource_2.designation
    end

  end
end
