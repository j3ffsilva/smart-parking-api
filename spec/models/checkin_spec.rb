describe Checkin do
  it 'should be valid when given valid attributes' do
    expect(build(:checkin)).to be_valid
  end

  specify 'a user cannot check-in simultaneously to more than one spot' do
    user = create(:user)
    spot = create(:spot)

    checkin     = create(:checkin, :pending, user: user, spot: spot)
    checkin_new = build(:checkin, user: user)

    checkin_new.valid?
    expect(checkin_new.errors[:user_id]).to \
      include('User is already checked in to another spot')
  end

  specify 'a spot cannot be simultaneously occupied by more than a user' do
    user1 = create(:user, email: 'user1@domain.com')
    user2 = create(:user, email: 'user2@domain.com')

    spot = create(:spot)

    checkin     = create(:checkin, :pending, user: user1, spot: spot)
    checkin_new = build(:checkin, :pending, user: user2, spot: spot)

    checkin_new.valid?
    expect(checkin_new.errors[:spot_id]).to include('Spot is taken')
  end

  describe 'methods for the JSON API gem' do
    it 'has attributes that are used for its JSON API representation' do
      expect(build(:checkin).json_api_attrs).to \
      eq(%w(checked_in_at_human spot_attributes))
    end
  end
end
