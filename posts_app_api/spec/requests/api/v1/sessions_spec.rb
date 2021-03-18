# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  include RequestHelpers

  describe 'api/v1/sessions' do
    it 'returns user token if user exists' do
      FactoryBot.create(:user, email: 'jane@example.com', token: 'user-token')

      post '/api/v1/sessions', params: { email: 'jane@example.com' }

      expect(parsed_response_body[:token]).to eq('user-token')
    end

    it 'returns unauthorized if user not found' do
      post '/api/v1/sessions', params: { email: 'john@example.com' }

      expect(response).to have_http_status(:unauthorized)
      expect(parsed_response_body[:token]).to be_nil
    end
  end
end
