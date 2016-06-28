class Checkin < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :spot

  # Validations
  validates :user, :spot, :checked_in_at, presence: true

  # A user cannot check-in simultaneously to more than one spot.
  # REVIEW: typo: simultaneously
  # REVIEW: use Ruby 1.9-style hash.
  validate :user_cannot_simultaneosly_checkin, :on => :create

  # A spot cannot be simultaneously occupied by more than a user.
  # REVIEW: typo: simultaneously
  # REVIEW: use Ruby 1.9-style hash.
  # REVIEW: improve method name.
  validate :spot_cannot_simultaneosly_occupied, :on => :create

  def user_cannot_simultaneosly_checkin
    c = Checkin.where(user_id: self.user_id, checked_out_at: nil)
    errors.add(:user_id, 'User has checkout pending') unless c.empty?
  end

  def spot_cannot_simultaneosly_occupied
    c = Checkin.where(spot_id: self.spot_id)
    # REVIEW: remove pluck to increase readability.
    if !c.empty? && !c.pluck(:checked_in_at).empty? && c.pluck(:checked_out_at)[0].nil?
      # REVIEW: fix English.
      errors.add(:spot_id, 'Spot is been occupied')
    end
  end

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(user_id spot_id checked_in_at checked_out_at)
  end
end
