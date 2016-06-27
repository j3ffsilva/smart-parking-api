class Incident < ActiveRecord::Base
  # Constants
  CATEGORIES = { other: 0, address: 1, schedule: 2, price: 3 }.freeze

  # Associations
  belongs_to :spot
  belongs_to :user

  # Validations
  # REVIEW: should also validate spot and user presence.
  # REVISIT: comment is mandatory?
  validates :category, :comment, presence: true
  validates :category, inclusion: { in: CATEGORIES.values }

  # Defines which attributes to include in the JSON API representation.
  def json_api_attrs(_options = {})
    # REVIEW: name_user should be user_name.
    # REVIEW: time_last_comment should be created_at_human
    # REVIEW: there is no way to update a comment or delete it.
    %w(category comment name_user time_last_comment)
  end

  # Defines which relationships to include in the JSON API representation.
  def json_api_relations(_options = {})
    %w(user)
  end

  def name_user
    user.name
  end

  # REVIEW: use distance_of_time_in_words helper.
  def time_last_comment
    seconds = (Time.now - updated_at).to_i
    minutes = (seconds / 60).to_i
    hours = (minutes / 60).to_i
    days = (hours / 24).to_i
    months = (days / 30).to_i
    years = (months / 12).to_i
    time = seconds == 0 ? 'just now' : seconds.to_s + ' second(s) ago'
    time = minutes == 0 ? time : minutes.to_s + ' minute(s) ago'
    time = hours == 0 ? time : hours.to_s + ' hour(s) ago'
    time = days == 0 ? time : days.to_s + ' day(s) ago'
    time = months == 0 ? time : months.to_s + ' month(s) ago'
    time = years == 0 ? time : years.to_s + ' year(s) ago'
    time
  end
end
