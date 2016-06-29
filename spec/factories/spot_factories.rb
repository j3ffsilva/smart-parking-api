FactoryGirl.define do
  factory :spot do
    # Default factory
    parking_type    'street'
    status          Spot::SPOT_STATUSES[:available]
    is_outdoor      true
    is_preferential false
    latitude        { Faker::Address.latitude }
    longitude       { Faker::Address.longitude }

    trait :invalid_status do
      status 500
    end

    trait :latitude_too_small do
      latitude -100.05
    end

    trait :latitude_too_large do
      latitude 100.05
    end

    trait :longitude_too_small do
      longitude -190.05
    end

    trait :longitude_too_large do
      longitude 200.05
    end
  end
end
