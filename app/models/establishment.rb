class Establishment < ActiveRecord::Base
  # Associations
  has_many :spots
  has_many :availability_schedules, through: :spots
  has_many :pricing_schedules,      through: :spots

  # Validations
  validates :google_place_id, presence: true

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(google_place_id)
  end
end
