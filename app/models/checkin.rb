class Checkin < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :spot

  # Validations
  validates :user, :spot, :checked_in_at, presence: true

  # A user cannot check-in simultaneously to more than one spot.
  validate :user_is_not_checked_in, on: :create

  # A spot cannot be simultaneously occupied by more than a user.
  validate :spot_is_not_occupied, on: :create

  def user_is_not_checked_in
    c = Checkin.where(user_id: self.user_id, checked_out_at: nil)
    errors.add(:user_id, 'User is already checked in to another spot') unless c.empty?
  end

  def spot_is_not_occupied
    c = Checkin.where(spot_id: self.spot_id, checked_out_at: nil)
    errors.add(:spot_id, 'Spot is taken') unless c.empty?
  end

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(checked_in_at_human spot_attributes)
  end

  # Defines which relationships to include in the JSON API representation.
  def spot_attributes
    {
      id: spot.id,
      lat: spot.latitude,
      lng: spot.longitude
    }
  end

  def checked_in_at_human
    checked_in_at.strftime("%b %d, %H:%M")
  end
end
