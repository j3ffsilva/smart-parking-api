class Checkin < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :spot

  # Validations
  validates :user, :spot, :checked_in_at, presence: true

  # A user cannot check-in simultaneously to more than one spot
  validate :user_cannot_simultaneosly_checkin

  # A spot cannot be simultaneously occupied by more than a user
  validate :spot_cannot_simultaneosly_occupied

  def user_cannot_simultaneosly_checkin
    c = Checkin.where(user_id: self.user_id, checked_out_at: nil)
    errors.add(:user_id, 'User has Checkout pending') unless c.empty?
  end

  def spot_cannot_simultaneosly_occupied
    c = Checkin.where(spot_id: self.spot_id)
    if !c.pluck(:checked_in_at).nil
      errors.add(:spot_id, 'Spot is been occupied')
    end
  end

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(id  user_id spot_id checked_in_at checked_out_at)
  end
end
