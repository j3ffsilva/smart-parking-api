RSpec.describe V1::SpotsController, type: :request do
  let(:api_header) {
    { 'Accept' => 'application/vnd.smartcityplatform; version=1' }
  }

  let(:api_client) { APIClient.first }

  describe 'spots search' do
    context 'with correct parameters' do
      it 'succeeds' do
        get '/spots/search',
            params: { lat: '0', lng: '0', token: api_client.token },
            headers: api_header

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        get '/spots/search',
            params: { token: api_client.token },
            headers: api_header

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with establishment' do
      it 'returns an error if the establishment is invalid' do
        get '/spots/search',
            params: { lat: '0', lng: '0', google_place_id: 'XYZ' },
            headers: api_header

        expect(response).to have_http_status(:bad_request)
      end

      it 'succeeds if the establishment is valid' do
        place_id = Establishment.first.google_place_id

        get '/spots/search',
            params: { lat: '0', lng: '0', google_place_id: place_id },
            headers: api_header

        expect(response).to have_http_status(:success)
      end
    end

    context 'with establishment' do
      it 'returns an error if one of the statuses is invalid' do
        get '/spots/search',
            params: { lat: '0', lng: '0', statuses: 'ABC' },
            headers: api_header

        expect(response).to have_http_status(:bad_request)
      end

      it 'succeeds if the statuses are valid' do
        get '/spots/search',
            params: { lat: '0', lng: '0', statuses: '0,1' },
            headers: api_header

        expect(response).to have_http_status(:success)
      end
    end
  end
end
