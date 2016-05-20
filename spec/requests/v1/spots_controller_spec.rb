RSpec.describe V1::SpotsController, type: :request do
  let(:api_header) {
    { 'Accept' => 'application/vnd.smartcityplatform; version=1' }
  }

  describe 'spots search' do
    context 'with correct parameters' do
      it 'succeeds' do
        get '/spots/search',
            params: { lat: '0', lng: '0' },
            headers: api_header

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        get '/spots/search', headers: api_header
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
