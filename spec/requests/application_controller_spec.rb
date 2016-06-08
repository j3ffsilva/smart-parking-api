RSpec.describe ApplicationController, type: :request do
  let(:api_client) { APIClient.first }

  it 'accepts a :pretty parameter' do
    get '/spots/search',
        params: { lat: '0', lng: '0', token: api_client.token, pretty: '1' },
        headers: { 'Accept' => 'application/vnd.smartcityplatform; version=1' }

    expect(response.body).to start_with("{\n")
    expect(response).to have_http_status(:success)
  end

  describe 'authentication' do
    it 'requires a :token parameter' do
      get '/spots/search',
          params: { lat: '0', lng: '0' },
          headers: { 'Accept' => 'application/vnd.smartcityplatform; version=1' }

      expect(response).to have_http_status(:bad_request)
    end

    it 'requires the :token parameter to identify a valid client' do
      get '/spots/search',
          params: { lat: '0', lng: '0', token: 'X' },
          headers: { 'Accept' => 'application/vnd.smartcityplatform; version=1' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
