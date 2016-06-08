RSpec.describe APIClient, type: :model do
  it 'should be valid when given valid attributes' do
    expect(build(:api_client)).to be_valid
  end

  specify "name can't be blank" do
    api_client = build(:api_client)
    api_client.name = nil
    expect(api_client.errors_on(:name)).to include("can't be blank")
  end
end
