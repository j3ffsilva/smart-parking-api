RSpec.describe V1::CheckinsController, type: :request do
  let(:api_header) {
    { 'Accept' => 'application/vnd.smartcityplatform; version=1' }
  }

  let(:api_client)            { APIClient.first }
  let(:default_params_create) { { checkin: { user_id: User.first.id,
                                             spot_id: Spot.first.id,
                                             checked_in_at: Time.now,
                                             checked_out_at: nil
                                           },
                                  token: api_client.token
                               } }

  let(:default_params_search) { { user_id: User.first.id, token: api_client.token } }

  describe 'checkins create' do
    context 'with correct parameters' do
      it 'succeeds' do
        post '/checkins',
          params: default_params_create,
          headers: api_header

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'checkins update' do
    context 'with correct parameters' do
      it 'succeeds' do
        checkin = create(:checkin)
        post '/checkins/' + checkin.id.to_s,
              params: default_params_search,
              headers: api_header

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'checkins search' do
    context 'with correct parameters' do
      it 'succeeds' do
        get '/checkins/search',
          params: default_params_search,
          headers: api_header

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:success)
      end
    end
  end
end
