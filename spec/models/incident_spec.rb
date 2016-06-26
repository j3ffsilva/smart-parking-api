describe Incident do
  it 'should be valid when given valid attributes' do
    expect(build(:incident)).to be_valid
  end

  it 'should have a valid category' do
    incident = build(:incident, :invalid_category)
    expect(incident).to have(1).error_on(:category)
  end

  [:category, :comment].each do |attr|
    specify "#{attr} can't be blank" do
      incident = build(:incident)
      incident[attr] = nil
      expect(incident.errors_on(attr)).to include("can't be blank")
    end
  end

  describe 'methods for the JSON API gem' do
    it 'has attributes that are used for its JSON API representation' do
      expect(build(:incident).json_api_attrs).to \
        eq(%w(category comment name_user time_last_comment))
    end

    it 'includes users' do
      expect(build(:incident).json_api_relations).to include('user')
    end
  end
end
