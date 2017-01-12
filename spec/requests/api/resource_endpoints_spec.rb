# 123e4567-e89b-12d3-a456-426655440000

require 'rails_helper'

describe Api::ApiController, type: :request do
  Settings.slot_configuration.increment = 30
  Settings.slot_configuration.end_time = 20

  describe 'create resource endpoint' do
    let!(:facility) { create(:facility, code: 'qwer')}
    it 'creates an object with valid request' do
      post api_resources_path, {params: {resource: {uuid: '123e4567-e89b-12d3-a456-426655440000',
                                                    f_code: facility.code,
                                                    designation: 'New conference room',
                                                    capacity: 20,
                                                    direction: 'left'}}, headers: {'HTTP_ACCEPT': 'application/json'}}

      new_object = Resource.last
      expected_response = {id: new_object.id,
                           uuid: '123e4567-e89b-12d3-a456-426655440000',
                           designation: 'New conference room'}
      expect(response_json).to eq expected_response.as_json
    end

    it 'reject object creation without facility' do
      post api_resources_path, {params: {resource: {uuid: '123e4567-e89b-12d3-a456-426655440000',
                                                    f_code: '',
                                                    designation: 'New conference room',
                                                    capacity: 20,
                                                    direction: 'left'}}, headers: {'HTTP_ACCEPT': 'application/json'}}

      expected_error_response = ['Facility can\'t be blank'].sort
      expect(response_json['message']).to eq expected_error_response
    end

    it 'reject object creation on invalid request' do
      post api_resources_path, {params: {resource: {uuid: '123e4567-e89b-12d3-a456-426655440000'}}, headers: {'HTTP_ACCEPT': 'application/json'}}
      expected_error_response = [
        "Capacity is not a number",
        "Capacity can't be blank",
        "Designation can't be blank",
        "Facility can't be blank",
        "Direction can't be blank"
      ].sort

      expect(response_json['message']).to eq expected_error_response
    end


    it 'reject object creation without uuid' do
      post api_resources_path, {params: {resource: {uuid: '',
                                                    f_code: facility.code,
                                                    designation: 'New conference room',
                                                    capacity: 20,
                                                    direction: 'left'}}, headers: {'HTTP_ACCEPT': 'application/json'}}

      expected_error_response = ['Uuid can\'t be blank'].sort
      expect(response_json['message']).to eq expected_error_response
    end

    it 'updates object' do

      object = FactoryGirl.create(:resource, uuid: '123e4567-e89b-12d3-a456-426655440000')
      put '/api/resources/', {params: {uuid: object.uuid, resource: {uuid: '123e4567-e89b-12d3-a456-426655440000',
                                                                     designation: 'Conference room',
                                                                     capacity: 20,
                                                                     direction: 'left'}}, headers: {'HTTP_ACCEPT': 'application/json'}}
      object = Resource.find_by(uuid: '123e4567-e89b-12d3-a456-426655440000')
      expected_response = {id: object.id,
                           uuid: '123e4567-e89b-12d3-a456-426655440000',
                           designation: 'Conference room'}
      expect(response_json).to eq expected_response.as_json

    end
  end

  describe 'resource show' do
    let!(:resource_1) { FactoryGirl.create(:resource,
                                           uuid: '123e4567-e89b-12d3-a456-426655440000') }

    let(:user) { FactoryGirl.create(:user) }

    before do
      Timecop.freeze('2016-01-01')
      from = Date.today + 15.hour + 30.minutes
      to = from + 1.hour
      @booking = resource_1.be_booked! user, time_start: from, time_end: to, amount: 4, client: 'Craft Academy'
    end

    it 'fetches bookings for a resource' do
      expected_response = {'designation': resource_1.designation,
                           'uuid': resource_1.uuid,
                           'id': resource_1.id,
                           'slots': [
                               {
                                   'info': {
                                       'time': '08:00 - 08:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '08:30 - 09:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '09:00 - 09:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '09:30 - 10:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '10:00 - 10:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '10:30 - 11:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '11:00 - 11:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '11:30 - 12:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '12:00 - 12:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '12:30 - 13:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '13:00 - 13:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '13:30 - 14:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '14:00 - 14:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '14:30 - 15:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '15:00 - 15:30'
                                   },
                                   'state': 'free'
                               },
                               {'info': {'id': 1, 'time': '15:30 - 16:00', 'client': 'Craft Academy', 'booking_time': '15:30 - 16:30'},
                                'state': 'booked'},
                               {'info': {'id': 1, 'time': '16:00 - 16:30', 'client': 'Craft Academy', 'booking_time': '15:30 - 16:30'},
                                'state': 'booked'},
                               {
                                   'info': {
                                       'time': '16:30 - 17:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '17:00 - 17:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '17:30 - 18:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '18:00 - 18:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '18:30 - 19:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '19:00 - 19:30'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '19:30 - 20:00'
                                   },
                                   'state': 'free'
                               },
                               {
                                   'info': {
                                       'time': '20:00 - 20:30'
                                   },
                                   'state': 'free'
                               }
                           ]
      }
      get show_api_resources_path(uuid: resource_1.uuid), headers: {'HTTP_ACCEPT': 'application/json'}
      expect(response_json).to eq expected_response.as_json
    end

  end
  describe 'resources index endpoint' do
    let!(:resource_1) { FactoryGirl.create(:resource) }
    let!(:resource_2) { FactoryGirl.create(:resource) }
    let(:user) { FactoryGirl.create(:user) }

    before do
      Timecop.freeze('2016-01-01')
      from = Date.today + 15.hour + 30.minutes
      to = from + 1.hour
      @booking = resource_1.be_booked! user, time_start: from, time_end: to, amount: 4, client: 'Craft Academy'
    end

    it 'lists bookings for resource' do
      expected_response = {
          'items': [
              {'designation': resource_1.designation,
               'uuid': resource_1.uuid,
               'id': resource_1.id,
               'slots': [
                   {
                       'info': {
                           'id': 1,
                           'time': '08:00 - 08:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 2,
                           'time': '08:30 - 09:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 3,
                           'time': '09:00 - 09:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 4,
                           'time': '09:30 - 10:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 5,
                           'time': '10:00 - 10:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 6,
                           'time': '10:30 - 11:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 7,
                           'time': '11:00 - 11:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 8,
                           'time': '11:30 - 12:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 9,
                           'time': '12:00 - 12:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 10,
                           'time': '12:30 - 13:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 11,
                           'time': '13:00 - 13:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 12,
                           'time': '13:30 - 14:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 13,
                           'time': '14:00 - 14:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 14,
                           'time': '14:30 - 15:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 15,
                           'time': '15:00 - 15:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 16,
                           'time': '15:30 - 16:00',
                           'client': 'Craft Academy',
                           'booking_time': '15:30 - 16:30'
                       },
                       'state': 'booked'
                   },
                   {
                       'info': {
                           'id': 17,
                           'time': '16:00 - 16:30',
                           'client': 'Craft Academy',
                           'booking_time': '15:30 - 16:30'
                       },
                       'state': 'booked'
                   },
                   {
                       'info': {
                           'id': 18,
                           'time': '16:30 - 17:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 19,
                           'time': '17:00 - 17:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 20,
                           'time': '17:30 - 18:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 21,
                           'time': '18:00 - 18:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 22,
                           'time': '18:30 - 19:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 23,
                           'time': '19:00 - 19:30'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 24,
                           'time': '19:30 - 20:00'
                       },
                       'state': 'free'
                   },
                   {
                       'info': {
                           'id': 25,
                           'time': '20:00 - 20:30'
                       },
                       'state': 'free'
                   }
               ]
              }, {
                  'designation': resource_2.designation,
                  'uuid': resource_2.uuid,
                  'id': resource_2.id,
                  'slots': [
                      {
                          'info': {
                              'id': 1,
                              'time': '08:00 - 08:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 2,
                              'time': '08:30 - 09:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 3,
                              'time': '09:00 - 09:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 4,
                              'time': '09:30 - 10:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 5,
                              'time': '10:00 - 10:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 6,
                              'time': '10:30 - 11:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 7,
                              'time': '11:00 - 11:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 8,
                              'time': '11:30 - 12:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 9,
                              'time': '12:00 - 12:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 10,
                              'time': '12:30 - 13:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 11,
                              'time': '13:00 - 13:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 12,
                              'time': '13:30 - 14:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 13,
                              'time': '14:00 - 14:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 14,
                              'time': '14:30 - 15:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 15,
                              'time': '15:00 - 15:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 16,
                              'time': '15:30 - 16:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 17,
                              'time': '16:00 - 16:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 18,
                              'time': '16:30 - 17:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 19,
                              'time': '17:00 - 17:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 20,
                              'time': '17:30 - 18:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 21,
                              'time': '18:00 - 18:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 22,
                              'time': '18:30 - 19:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 23,
                              'time': '19:00 - 19:30'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 24,
                              'time': '19:30 - 20:00'
                          },
                          'state': 'free'
                      },
                      {
                          'info': {
                              'id': 25,
                              'time': '20:00 - 20:30'
                          },
                          'state': 'free'
                      }
                  ]
              }
          ]
      }
      get api_resources_path, headers: {'HTTP_ACCEPT': 'application/json'}
      expect(response_json['items'][0]).to eq expected_response[:items][0].as_json
      expect(response_json['items'][1]['designation']).to eq resource_2.designation
    end

  end
end
