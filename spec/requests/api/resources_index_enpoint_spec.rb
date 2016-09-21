require 'rails_helper'

describe Api::ApiController, type: :request do
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
                 {
                     'info': {
                         'time': '16:00 - 16:30'
                     },
                     'state': 'free'
                 },
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
            }, {
                'designation': resource_2.designation,
                'uuid': resource_2.uuid,
                'id': resource_2.id,
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
                    {
                        'info': {
                            'time': '15:30 - 16:00'
                        },
                        'state': 'free'
                    },
                    {
                        'info': {
                            'time': '16:00 - 16:30'
                        },
                        'state': 'free'
                    },
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
        ]
    }
    get api_resources_path, headers: {'HTTP_ACCEPT': 'application/json'}
    expect(response_json['items'][0]).to eq expected_response[:items][0].as_json
    expect(response_json['items'][1]['designation']).to eq resource_2.designation
  end
end
