class Establishment < ActiveRecord::Base
  # Associations
  has_many :spots
  has_many :availability_schedules, through: :spots
  has_many :pricing_schedules,      through: :spots

  # Validations
  validates :google_place_id, presence: true
end
