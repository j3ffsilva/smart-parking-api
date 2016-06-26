RSpec.describe V1::IncidentsController, type: :request do
  let(:api_header) {
    { 'Accept' => 'application/vnd.smartcityplatform; version=1' }
  }

  let(:api_client)            { APIClient.first }
  let(:default_params_last)   { { spot: 1, token: api_client.token } }
  let(:default_params_create) { { incident: { user: User.first.id,
                                              spot: Spot.first.id,
                                              category: 0,
                                              comment: 'comment'
                                            },
                                  token: api_client.token
                              } }

  describe 'incidents last' do
    context 'with correct parameters' do
      it 'succeeds' do
        get '/incidents/last',
            params: default_params_last,
            headers: api_header

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        get '/incidents/last',
            params: { token: api_client.token },
            headers: api_header

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'incidents create' do
    context 'with correct parameters' do
      it 'succeeds' do
        post '/incidents',
             params: default_params_create,
             headers: api_header

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end
  end
end
