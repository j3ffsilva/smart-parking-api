RSpec.describe SmartCityPlatform::DiscoveryService do
  describe 'radius_search' do
    it 'fails if the API is not available' do
      results = SmartCityPlatform::DiscoveryService::radius_search(
        lat: -23, lng: -46, range: 1000
      )

      expect(results).to be_a(Hash)
      expect(results[:success]).to be_falsy
    end
  end
end
