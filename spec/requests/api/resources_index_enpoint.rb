require 'rails_helper'

describe Api::ApiController, type: :request do
  let!(:resource_1) { FactoryGirl.create(:resource) }
  let!(:resource_2) { FactoryGirl.create(:resource) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    Timecop.freeze('2016-01-01')
    from = Date.today + 15.hour + 30.minutes
    to = from + 1.hour
    @booking = resource_1.be_booked! user, time_start: from, time_end: to, amount: 4
  end

  it 'lists bookings for resource' do
    expected_response = {
        "items": [
            {
                "id": resource_1.id,
                "slots": [
                    {
                        "info": {
                            "id": 0,
                            "time": "08:00 - 08:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 1,
                            "time": "08:30 - 09:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 2,
                            "time": "09:00 - 09:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 3,
                            "time": "09:30 - 10:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 4,
                            "time": "10:00 - 10:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 5,
                            "time": "10:30 - 11:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 6,
                            "time": "11:00 - 11:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 7,
                            "time": "11:30 - 12:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 8,
                            "time": "12:00 - 12:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 9,
                            "time": "12:30 - 13:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 10,
                            "time": "13:00 - 13:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 11,
                            "time": "13:30 - 14:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 12,
                            "time": "14:00 - 14:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 13,
                            "time": "14:30 - 15:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 14,
                            "time": "15:00 - 15:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 15,
                            "time": "15:30 - 16:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 16,
                            "time": "16:00 - 16:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 17,
                            "time": "16:30 - 17:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 18,
                            "time": "17:00 - 17:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 19,
                            "time": "17:30 - 18:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 20,
                            "time": "18:00 - 18:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 21,
                            "time": "18:30 - 19:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 22,
                            "time": "19:00 - 19:30"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 23,
                            "time": "19:30 - 20:00"
                        },
                        "state": "free"
                    },
                    {
                        "info": {
                            "id": 24,
                            "time": "20:00 - 20:30"
                        },
                        "state": "free"
                    }
                ]
            },  {
            "id": resource_1.id,
            "slots": [
                {
                    "info": {
                        "id": 0,
                        "time": "08:00 - 08:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 1,
                        "time": "08:30 - 09:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 2,
                        "time": "09:00 - 09:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 3,
                        "time": "09:30 - 10:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 4,
                        "time": "10:00 - 10:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 5,
                        "time": "10:30 - 11:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 6,
                        "time": "11:00 - 11:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 7,
                        "time": "11:30 - 12:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 8,
                        "time": "12:00 - 12:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 9,
                        "time": "12:30 - 13:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 10,
                        "time": "13:00 - 13:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 11,
                        "time": "13:30 - 14:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 12,
                        "time": "14:00 - 14:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 13,
                        "time": "14:30 - 15:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 14,
                        "time": "15:00 - 15:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 15,
                        "time": "15:30 - 16:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 16,
                        "time": "16:00 - 16:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 17,
                        "time": "16:30 - 17:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 18,
                        "time": "17:00 - 17:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 19,
                        "time": "17:30 - 18:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 20,
                        "time": "18:00 - 18:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 21,
                        "time": "18:30 - 19:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 22,
                        "time": "19:00 - 19:30"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 23,
                        "time": "19:30 - 20:00"
                    },
                    "state": "free"
                },
                {
                    "info": {
                        "id": 24,
                        "time": "20:00 - 20:30"
                    },
                    "state": "free"
                }
            ]
        }
        ]
    }
    #get '/api/resources/index'
    get api_resources_path, headers: {'HTTP_ACCEPT': 'application/json'}
    expect(response_json).to eq expected_response.as_json
  end
end