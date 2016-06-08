module Schedulable
  # Converts a schedulable object to a human-readable description.
  def human_description(value)
    "#{formatted_weekday(from)}-#{formatted_weekday(to)} | " \
      "#{formatted_time(begin_time)} to #{formatted_time(end_time)}: #{value}"
  end

  def formatted_time(time)
    time.strftime('%H:%M:%S')
  end

  def formatted_weekday(index)
    Date::DAYNAMES[index][0..2]
  end
end
