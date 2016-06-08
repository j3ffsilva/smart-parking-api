# This data can be loaded with the rails db:seed command (or created
# alongside the database with db:setup).

data = YAML
       .load(File.read("#{Rails.root}/db/data.yml"))
       .with_indifferent_access

data['spots'].each do |spot_data|
  spot = Spot.where(
    latitude: spot_data[:latitude],
    longitude: spot_data[:longitude]
  ).first_or_initialize(
    parking_type: spot_data[:parking_type],
    status: spot_data[:status],
    is_outdoor: spot_data[:is_outdoor],
    is_preferential: spot_data[:is_preferential]
  )

  # This spot already exists in the database, so we will not re-create it.
  next if spot.persisted?

  if (establishment_data = spot_data[:establishment])
    establishment = Establishment
                    .where(
                      google_place_id: establishment_data[:google_place_id]
                    ).first_or_initialize
  else
    establishment = nil
  end

  if (pricing_data = spot_data[:pricing_schedules]).any?
    pricing_schedules = pricing_data.map do |pricing_schedule|
      PricingSchedule.new(
        from: pricing_schedule[:from],
        to: pricing_schedule[:to],
        begin_time: pricing_schedule[:begin_time],
        end_time: pricing_schedule[:end_time],
        price: pricing_schedule[:price]
      )
    end
  else
    pricing_schedules = []
  end

  if (availability_data = spot_data[:availability_schedules]).any?
    availability_schedules = availability_data.map do |availability_schedule|
      AvailabilitySchedule.new(
        from: availability_schedule[:from],
        to: availability_schedule[:to],
        begin_time: availability_schedule[:begin_time],
        end_time: availability_schedule[:end_time],
        is_available: availability_schedule[:is_available]
      )
    end
  else
    availability_schedules = []
  end

  ActiveRecord::Base.transaction do
    if establishment
      establishment.save!
    end

    spot.establishment = establishment
    spot.save!

    spot.pricing_schedules = pricing_schedules
    spot.availability_schedules = availability_schedules
  end
end
