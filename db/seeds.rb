# This data can be loaded with the rails db:seed command (or created
# alongside the database with db:setup).

# This data was generated from the following Google Places API request:
#
# https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-23.533773,-46.625290&radius=5000&type=teatro&key=API_KEY
#
# The response was saved in 'db/theaters.json'.

# Remove all records before starting.
[AvailabilitySchedule, PricingSchedule, Spot, Establishment].each(&:destroy_all)

# Define utility methods
def format_time(time)
  time.strftime('%H:%M:%S')
end

data = JSON.parse(File.read("#{Rails.root}/db/theaters.json"))

data['results'].each do |place|
  establishment = Establishment.create!(google_place_id: place['id'])

  # Create 5 spots for each establishment.
  5.times do
    n1 = Faker::Number.between(0.00001, 0.001)
    n2 = Faker::Number.between(0.00001, 0.001)

    s = Spot.create!(
      parking_type: %w(street parking_lot establishment).sample,
      status: [-1, 0, 1].sample,
      is_outdoor: Faker::Boolean.boolean,
      is_preferential: Faker::Boolean.boolean,
      latitude: place['geometry']['location']['lat'] + n1,
      longitude: place['geometry']['location']['lng'] + n2
    )

    establishment.spots << s

    # Create 2 schedules of each type for each spot.
    2.times do
      t1   = Faker::Time.between(30.days.ago, 15.days.ago, :all)
      t2   = Faker::Time.between(14.days.ago, Date.today, :all)
      from = Faker::Number.between(0, 6)

      s.availability_schedules.create!(
        from: from,
        to: Faker::Number.between(from, 6),
        begin_time: format_time(t1),
        end_time: format_time(t2),
        is_available: Faker::Boolean.boolean
      )

      t1 = Faker::Time.between(30.days.ago, 15.days.ago, :all)
      t2 = Faker::Time.between(14.days.ago, Date.today, :all)
      from = Faker::Number.between(0, 6)

      s.pricing_schedules.create(
        from: from,
        to: Faker::Number.between(0, 6),
        begin_time: format_time(t1),
        end_time: format_time(t2),
        price: Faker::Number.decimal(2)
      )
    end
  end
end
