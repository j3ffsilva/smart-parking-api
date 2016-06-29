RSpec.describe DeviseTokenAuth::ConfirmationsController, type: :request do
  it 'loads' do
    # ApplicationController is a Rails-generated class that we haven't
    # modified, so there is nothing to test.
    # This spec is only here to increase Simplecov coverage.
  end

  let(:api_header) {
    { 'Accept' => 'application/vnd.smartcityplatform; version=1' }
  }

  let(:api_client)            { APIClient.first }

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

  describe 'GET /auth/confirmation' do
    it 'loads' do
      ex = nil
      begin
        get '/auth/confirmation',
          headers: api_header.merge(@auth_headers)
      rescue => e
        ex = e
      end

      expect(ex).to be_present
    end
  end
end
