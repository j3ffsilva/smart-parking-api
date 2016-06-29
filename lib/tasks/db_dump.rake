def serialize_schedule(schedule)
  attrs = schedule.attributes.select do |k, _|
    k.in? %(from to begin_time end_time is_available price)
  end

  attrs['begin_time'] = attrs['begin_time'].strftime('%H:%M')
  attrs['end_time'] = attrs['end_time'].strftime('%H:%M')

  attrs
end

SPOTS_FILE_PATH = Rails.root.join('db/spots.yml')

namespace :db do
  namespace :data do
    desc 'Dump parking spots data into a YAML file'
    task :dump => :environment do

      data = { 'spots' => [] }

      Spot.all.map do |s|
        spot = s.attributes.select do |k, _|
          k.in?(%w(parking_type status is_outdoor is_preferential latitude longitude reference))
        end

        if s.establishment
          spot['establishment'] = {
            google_place_id: s.establishment.google_place_id
          }
        end

        if s.availability_schedules.any?
          spot['availability_schedules'] = s.availability_schedules.map do |a|
            serialize_schedule(a)
          end
        else
          spot['availability_schedules'] = []
        end

        if s.pricing_schedules.any?
          spot['pricing_schedules'] = s.pricing_schedules.map do |a|
            serialize_schedule(a)
          end
        else
          spot['pricing_schedules'] = []
        end

        # Print progress
        print '.'

        data['spots'] << spot
      end

      File.open(SPOTS_FILE_PATH, 'w') do |f|
        f.write(data.to_yaml)
      end

      puts
      puts "Data was dumped to: #{SPOTS_FILE_PATH}"
    end

    desc 'Load parking spots data from a YAML file'
    task :load => :environment do
      unless (File.exist?(SPOTS_FILE_PATH))
        puts "[error] File #{SPOTS_FILE_PATH} does not exist."
        next
      end

      # Delete previous data
      PricingSchedule.destroy_all
      AvailabilitySchedule.destroy_all
      Checkin.destroy_all
      # Incident.destroy_all
      Spot.destroy_all
      Establishment.destroy_all

      data = YAML.load(File.read(SPOTS_FILE_PATH))
      count = 0
      keep_going=false

      puts 'Importing parking spots data:'

      data['spots'].each do |spot_attrs|
        begin

          spot = Spot.new(
            parking_type:    spot_attrs['parking_type'],
            status:          spot_attrs['status'],
            is_outdoor:      spot_attrs['is_outdoor'],
            is_preferential: spot_attrs['is_preferential'],
            latitude:        spot_attrs['latitude'],
            longitude:       spot_attrs['longitude'],
            reference:       spot_attrs['reference'],
          )

          if spot_attrs['establishment'].is_a?(Hash)
            establishment = Establishment.where(
                              google_place_id: spot_attrs['establishment'][:google_place_id]
                            ).first_or_initialize

            if establishment.new_record?
              establishment.save!
            end

            spot.establishment = establishment
          end

          spot.save!

          spot_attrs['availability_schedules'].each do |schedule_attrs|
            schedule = AvailabilitySchedule.new(
              from:         schedule_attrs['from'],
              to:           schedule_attrs['to'],
              begin_time:   schedule_attrs['begin_time'],
              end_time:     schedule_attrs['end_time'],
              is_available: schedule_attrs['is_available'],
              spot:         spot
            )
            schedule.save!
          end

          spot_attrs['pricing_schedules'].each do |schedule_attrs|
            schedule = PricingSchedule.new(
              from:       schedule_attrs['from'],
              to:         schedule_attrs['to'],
              begin_time: schedule_attrs['begin_time'],
              end_time:   schedule_attrs['end_time'],
              price:      schedule_attrs['price'],
              spot:       spot
            )
            schedule.save!
          end

          print '.'
          count += 1

        rescue => ex
          puts ex.message
          puts ex.backtrace
          debugger
          raise unless keep_going
        end
      end

      puts
      puts "#{count} spots created!"

    end

  end
end
