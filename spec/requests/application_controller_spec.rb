RSpec.describe ApplicationController, type: :request do
  it 'accepts a :pretty parameter' do
    get '/spots/search',
        params: { lat: '0', lng: '0', pretty: '1' },
        headers: { 'Accept' => 'application/vnd.smartcityplatform; version=1' }

    expect(response.body).to start_with("{\n")
    expect(response).to have_http_status(:success)
  end
end
