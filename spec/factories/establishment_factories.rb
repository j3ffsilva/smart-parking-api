FactoryGirl.define do
  factory :establishment do
    # Default factory
    google_place_id 'ChIJ0WGkg4FEzpQRrlsz_whLqZs'

    factory :establishment_with_spots do
      transient do
        spots_count 1
      end

      after(:create) do |establishment, evaluator|
        create_list(:spot, evaluator.spots_count, establishment: establishment)
      end
    end
  end
end
