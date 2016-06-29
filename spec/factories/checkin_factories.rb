FactoryGirl.define do
  factory :checkin do
    # Default factory
    user
    spot
    checked_in_at   '2016-06-25 12:42:05'
    checked_out_at  '2016-06-26 12:42:05'
  end
end
