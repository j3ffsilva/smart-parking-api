describe Establishment do
  it 'should be valid when given valid attributes' do
    expect(build(:establishment)).to be_valid
  end

  it 'should have at least one associated spot' do
    expect(create(:establishment_with_spots).spots.length).to be(1)
  end
end
