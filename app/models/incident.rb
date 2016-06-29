class Incident < ActiveRecord::Base
  # Constants
  CATEGORIES = { other: 0, address: 1, schedule: 2, price: 3 }.freeze

  # Associations
  belongs_to :spot
  belongs_to :user

  # Validations
  validates :category, :comment, :user, :spot, presence: true
  validates :category, inclusion: { in: CATEGORIES.values }

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(category comment human_created_at)
  end

  def human_created_at
    helper.distance_of_time_in_words(created_at, Time.zone.now)
  end

  private

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::DateHelper
    end.new
  end
end
