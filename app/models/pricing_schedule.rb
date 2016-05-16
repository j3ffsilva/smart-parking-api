class PricingSchedule < ActiveRecord::Base
  # Associations
  belongs_to :spot

  # Validations
  validates :spot, :from, :to, :begin_time, :end_time, :price, presence: true
  validates :from, :to, inclusion: { in: (0..(Date::DAYNAMES.size - 1)).to_a }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
