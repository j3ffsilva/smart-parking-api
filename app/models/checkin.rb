class Checkin < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :spot
end
