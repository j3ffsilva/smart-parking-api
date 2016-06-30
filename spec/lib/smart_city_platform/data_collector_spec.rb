RSpec.describe SmartCityPlatform::DataCollector do
  describe 'latest_values' do
    it 'fails if the API is not available' do
      results = SmartCityPlatform::DataCollector::latest_values(
        [1, 2, 3]
      )

      expect(results).to be_a(Hash)
      expect(results[:success]).to be_falsy
    end
  end
end
