class Spot < ActiveRecord::Base
  acts_as_geolocated lat: 'latitude', lng: 'longitude'

  # Constants
  PARKING_TYPES = %w(street parking_lot establishment).freeze
  SPOT_STATUSES = { defected: -1, available: 0, occupied: 1 }.freeze

  # Associations
  belongs_to :establishment, optional: true
  has_many   :availability_schedules
  has_many   :pricing_schedules
  has_many   :checkins
  has_many   :incidents

  # Validations
  validates :parking_type, :status, :latitude, :longitude, presence: true

  validates :parking_type, inclusion: { in: PARKING_TYPES }
  validates :status, inclusion: { in: SPOT_STATUSES.values }
  validates :is_outdoor, :is_preferential, inclusion: { in: [true, false] }
  validates :latitude,  numericality: { greater_than_or_equal_to: -90,
                                        less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180,
                                        less_than_or_equal_to: 180 }

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(latitude longitude status parking_type formatted_details google_establishment_id)
  end

  # Defines which relationships to include in the JSON API representation.
  def json_api_relations(_options = {})
    %w(establishment)
  end

  def formatted_details
    parking_restrictions = availability_schedules
                           .reject(&:is_available)
                           .map(&:human_description)

    pricing_restrictions = pricing_schedules
                           .reject { |s| s.price.zero? }
                           .map(&:human_description)

    {
      parking_restrictions: parking_restrictions,
      pricing_restrictions: pricing_restrictions
    }
  end

  def google_establishment_id
    establishment ? establishment.google_place_id : nil
  end
end
