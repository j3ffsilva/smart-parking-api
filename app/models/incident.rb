class Incident < ActiveRecord::Base
  # Constants
  CATEGORIES = { address: 1, schedule: 2, price: 3 }.freeze

  # Associations
  belongs_to :user
  belongs_to :spot

  # Validations
  validates :category, :comment, presence: true
  validates :category, inclusion: { in: CATEGORIES.values }

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(category comment)
  end
end
