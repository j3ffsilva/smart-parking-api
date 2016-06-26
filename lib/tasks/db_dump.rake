require 'byebug'

def serialize_schedule(schedule)
  attrs = schedule.attributes.select do |k, _|
    k.in? %(from to begin_time end_time is_available price)
  end

  attrs['begin_time'] = attrs['begin_time'].strftime('%H:%M')
  attrs['end_time'] = attrs['end_time'].strftime('%H:%M')

  attrs
end

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

      file_path = Rails.root.join('spots.yml')

      File.open(file_path, 'w') do |f|
        f.write(data.to_yaml)
      end

      puts
      puts "Data was dumped to: #{file_path}"
    end
  end
end
