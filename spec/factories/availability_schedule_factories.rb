FactoryGirl.define do
  factory :availability_schedule do
    # Default factory
    spot
    from         Date::DAYNAMES.index('Monday')
    to           Date::DAYNAMES.index('Friday')
    begin_time   '15:00:00'
    end_time     '19:00:00'
    is_available true

    trait :from_too_small do
      from -10
    end

    trait :from_too_large do
      from 10
    end

    trait :to_too_small do
      to -10
    end

    trait :to_too_large do
      to 10
    end
  end
end
