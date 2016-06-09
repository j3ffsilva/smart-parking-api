describe Spot do
  it 'should be valid when given valid attributes' do
    expect(build(:spot)).to be_valid
  end

  it 'should have a valid status' do
    spot = build(:spot, :invalid_status)
    expect(spot).to have(1).error_on(:status)
  end

  describe 'latitude' do
    it 'should not be too small' do
      spot = build(:spot, :latitude_too_small)
      expect(spot).to have(1).error_on(:latitude)
    end
    it 'should not be too large' do
      spot = build(:spot, :latitude_too_large)
      expect(spot).to have(1).error_on(:latitude)
    end
  end

  describe 'longitude' do
    it 'should not be too small' do
      spot = build(:spot, :longitude_too_small)
      expect(spot).to have(1).error_on(:longitude)
    end
    it 'should not be too large' do
      spot = build(:spot, :longitude_too_large)
      expect(spot).to have(1).error_on(:longitude)
    end
  end

  [:parking_type, :status, :latitude, :longitude].each do |attr|
    specify "#{attr} can't be blank" do
      spot = build(:spot)
      spot[attr] = nil
      expect(spot.errors_on(attr)).to include("can't be blank")
    end
  end

  describe 'methods for the JSON API gem' do
    it 'has attributes that are used for its JSON API representation' do
      expect(build(:spot).json_api_attrs).to \
        eq(%w(latitude longitude status parking_type formatted_details google_establishment_id))
    end

    it 'includes establishments' do
      expect(build(:spot).json_api_relations).to include('establishment')
    end

    it 'has formatting support' do
      expect(build(:spot).formatted_details).to be_a(Hash)
    end
  end

  describe '#google_establishment_id' do
    context 'when the establishment is nil' do
      it 'returns nil' do
        expect(build(:spot).google_establishment_id).to be_nil
      end
    end
  end
end
