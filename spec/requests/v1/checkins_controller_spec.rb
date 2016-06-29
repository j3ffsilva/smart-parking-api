RSpec.describe V1::CheckinsController, type: :request do
  let(:api_header) {
    { 'Accept' => 'application/vnd.smartcityplatform; version=1' }
  }

  let(:api_client)            { APIClient.first }

  let(:default_params_create) {
    {
      spot_id: Spot.first.id,
      token: api_client.token
    }
  }

  let(:default_params_search) { { user_id: User.first.id, token: api_client.token } }

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

  describe '/checkins/create' do
    context 'with correct parameters' do
      it 'succeeds' do
        post '/checkins',
          params: default_params_create,
          headers: api_header.merge(@auth_headers)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        post '/checkins',
            params: default_params_create.merge(spot_id: 0),
            headers: api_header.merge(@auth_headers)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '/checkins/checkout' do
    context 'with correct parameters' do
      it 'succeeds' do
        spot    = create(:spot)
        checkin = create(:checkin, :pending, user: @resource, spot: spot)

        post '/checkins/checkout',
              params: { token: api_client.token },
              headers: api_header.merge(@auth_headers)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        spot    = create(:spot)
        checkin = create(:checkin, user: @resource, spot: spot)

        post '/checkins/checkout',
              params: { token: api_client.token },
              headers: api_header.merge(@auth_headers)

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '/pending' do
    context 'with correct parameters' do
      it 'succeeds' do
        spot    = create(:spot)
        checkin = create(:checkin, :pending, user: @resource, spot: spot)

        get '/checkins/pending',
          params: { token: api_client.token },
          headers: api_header.merge(@auth_headers)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end
  end
end
