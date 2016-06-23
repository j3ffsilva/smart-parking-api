class Incident < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :spot

  # Validations
  validates :category, :description, presence: true

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(category description)
  end
end
