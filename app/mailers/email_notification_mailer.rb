class EmailNotificationMailer < ApplicationMailer
  def email_notification(email_notification)
    @email_notification = email_notification
    attachments.inline['bus.png'] = File.read('app/assets/images/white_logo.png')
    @booked_by = User.find_by(email: @email_notification.email)
    hour, minute = @email_notification.time.to_s.split()[1].split(':')
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
    mail(to: @booked_by.email, subject: "Your Journey Details for #{email_notification.date.strftime("%a, %d %b %Y")} #{@formatted_time} | Bus Ticket Manager")
  end
end
