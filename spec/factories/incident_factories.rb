FactoryGirl.define do
  factory :incident do
    # Default factory
    user
    spot
    category    Incident::CATEGORIES[:address]
    comment     'wrong address'

    trait :invalid_category do
      category 77
    end
  end
end
