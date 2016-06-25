class Incident < ActiveRecord::Base
  # Constants
  CATEGORIES = { other: 0, address: 1, schedule: 2, price: 3 }.freeze

  # Associations
  belongs_to :user
  belongs_to :spot

  # Validations
  validates :category, :comment, presence: true
  validates :category, inclusion: { in: CATEGORIES.values }

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    %w(category comment name_user time_last_comment)
  end

  # Defines which relationships to include in the JSON API representation.
  def json_api_relations(_options = {})
    %w(user)
  end

  def name_user
    user.name
  end

  def time_last_comment
    seconds = Time.now - updated_at
    minutes = (seconds / 60).to_i
    hours = (minutes / 60).to_i
    days = (hours / 24).to_i
    months = (days / 30).to_i
    years = (months / 12).to_i
    time = years == 0 ? '' : years.to_s + ' year(s) ago'
    time = months == 0 ? time : months.to_s + ' month(s) ago'
    time = days == 0 ? time : days.to_s + ' day(s) ago'
    time = hours == 0 ? time : hours.to_s + ' hour(s) ago'
    time = minutes == 0 ? time : minutes.to_s + ' minute(s) ago'
    time = seconds == 0 ? time : seconds.to_s + ' second(s) ago'
  end
end
