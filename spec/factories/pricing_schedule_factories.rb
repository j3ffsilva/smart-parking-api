FactoryGirl.define do
  factory :pricing_schedule do
    # Default factory
    spot
    from       Date::DAYNAMES.index('Saturday')
    to         Date::DAYNAMES.index('Sunday')
    begin_time '15:00:00'
    end_time   '19:00:00'
    price      15

    trait :invalid_price do
      price -20.0
    end

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
