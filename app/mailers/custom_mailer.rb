class CustomMailer < ApplicationMailer
  def custom_mailer(email, password)
    attachments.inline['bus.png'] = File.read('app/assets/images/white_logo.png')
    @ticket = email 
    @booking = password
    @booked_by = User.find(@ticket.booked_by_id)
    hour, minute = @booking.time.to_s.split()[1].split(':')
    hour = hour.to_i 
    if hour < 12
      meridiem = "AM" 
    else 
      meridiem = "PM"
    end 
    if hour == 0
      hour = 12
    elsif hour > 12
      hour -= 12
    end
    @formatted_time = "#{hour}:#{minute} #{meridiem}"
    mail(to: @booked_by.email, subject: "Your Journey Details for #{@booking.day} #{@formatted_time} | Bus Ticket Manager" )
  end
end
