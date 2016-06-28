describe Checkin do
  it 'should be valid when given valid attributes' do
    expect(build(:checkin)).to be_valid
  end

  specify 'a user cannot check-in simultaneously to more than one spot' do
    user = create(:user)
    spot = create(:spot)
    checkin = create(:checkin, user_id: user.id, spot_id: spot.id, checked_in_at: Time.now, checked_out_at: nil)
    checkin_new = build(:checkin, user_id: user.id)
    checkin_new.user_cannot_simultaneosly_checkin
    expect(checkin_new.errors[:user_id]).to include('User has checkout pending')
  end

  specify 'a spot cannot be simultaneously occupied by more than a user' do
    user1 = create(:user, email: 'emailtest1@testdomain.com', password: 'ewwasfasd')
    user2 = create(:user, email: 'emailtest2@testdomain.com', password: 'sdrtgtrew', reset_password_token: '1')
    spot = create(:spot)
    checkin = create(:checkin, user_id: user1.id, spot_id: spot.id, checked_in_at: Time.now, checked_out_at: nil)
    checkin_new = build(:checkin, user_id: user2.id, spot_id: spot.id, checked_in_at: Time.now, checked_out_at: nil)
    checkin_new.spot_cannot_simultaneosly_occupied
    expect(checkin_new.errors[:spot_id]).to include('Spot is been occupied')
  end

  describe 'methods for the JSON API gem' do
    it 'has attributes that are used for its JSON API representation' do
      expect(build(:checkin).json_api_attrs).to \
      eq(%w(user_id spot_id checked_in_at checked_out_at))
    end
  end
end
