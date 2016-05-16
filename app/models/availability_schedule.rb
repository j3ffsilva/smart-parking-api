class AvailabilitySchedule < ActiveRecord::Base
  # Associations
  belongs_to :spot

  # Validations
  validates :spot, :from, :to, :begin_time, :end_time, :is_available,
            presence: true
  validates :from, :to, inclusion: { in: (0..(Date::DAYNAMES.size - 1)).to_a }
end
