class AvailabilitySchedule < ActiveRecord::Base
  include Schedulable

  # Associations
  belongs_to :spot

  # Validations
  validates :spot, :from, :to, :begin_time, :end_time, presence: true
  validates :is_available, inclusion: { in: [true, false] }
  validates :from, :to, inclusion: { in: (0..(Date::DAYNAMES.size - 1)).to_a }

  def human_description
    super('unavailable')
  end
end
