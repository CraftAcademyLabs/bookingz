require 'rails_helper'

describe Api::ApiController, type: :request do
  describe 'Ping endpoint' do
    it 'GET /api/ping' do
      get '/api/ping'
      expect(response.status).to eq 200
      expect(response_json['message']).to eq 'Pong'
    end
  end
end