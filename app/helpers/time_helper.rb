module TimeHelper
  def generate_time_options
    start_time = Time.parse("12:00 am")
    end_time = Time.parse("11:59 pm")
    step = 5.minute

    times = []
    current_time = start_time

    while current_time <= end_time
      times << current_time.strftime("%I:%M %p")
      current_time += step
    end

    times
  end
end
