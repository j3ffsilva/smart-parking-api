FactoryGirl.define do
  factory :checkin do
    # Default factory
    user
    spot
    checked_in_at   '2016-06-25 12:42:05'
    checked_out_at  '2016-06-26 12:42:05'

    trait :pending do
      checked_in_at  { Time.zone.now }
      checked_out_at nil
    end
  end
end
