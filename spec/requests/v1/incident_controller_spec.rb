RSpec.describe V1::IncidentsController, type: :request do
  let(:api_header) {
    { 'Accept' => 'application/vnd.smartcityplatform; version=1' }
  }

  let(:api_client)            { APIClient.first }

  let(:default_params_create) {
    {
      token: api_client.token,
      incident: {
        spot_id: Spot.first.id,
        category: 1,
        comment: 'comment'
      }
    }
  }

  before(:each) do
    @resource = build(:user)
    @resource.skip_confirmation!
    @resource.save!

    @auth_headers = @resource.create_new_auth_token

    @token     = @auth_headers['access-token']
    @client_id = @auth_headers['client']
    @expiry    = @auth_headers['expiry']

    # Ensure that request is not treated as batch request
    DeviseTokenAuthSpecHelper.age_token(@resource, @client_id)
  end

  describe 'GET index incident spot' do
    context 'with correct parameter' do
      it 'succeeds' do
        get '/incidents/' + Spot.first.id.to_s,
          headers: api_header.merge(@auth_headers)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST create incident spot' do
    context 'with correct parameters' do
      it 'returns ok' do
        post '/incidents',
          params: default_params_create,
          headers: api_header.merge(@auth_headers)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with incorrect spot parameter' do
      it 'returns error when a spot is incorrect' do
        post '/incidents',
          params: {
            token: api_client.token,
            incident: {
              spot_id: 's',
              category: 0,
              comment: 'comment'
            }
          },
          headers: api_header.merge(@auth_headers)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with incorrect category parameter' do
      it 'returns error' do
        post '/incidents',
          params: {
            token: api_client.token,
            incident: {
              spot_id: Spot.first.id,
              category: -1,
              comment: 'comment'
            }
          },
          headers: api_header.merge(@auth_headers)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
