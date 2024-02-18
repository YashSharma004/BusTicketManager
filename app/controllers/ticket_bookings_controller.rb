class TicketBookingsController < ApplicationController
  # include TimeHelpers
  def new
  if params[:ticket_id].present?
    @ticket = Ticket.find(params[:ticket_id])
    @previous_bookings = TicketBooking.where(ticket_id: @ticket.id)
    @booking = @ticket.ticket_bookings.build
    @remaining_bookings = @ticket.booked_count - @ticket.ticket_bookings.count
  else
    redirect_to my_tickets_users_path, notice: 'Select a Ticket Weeek to Add/Save Details'
  end
end

def create
  @ticket = Ticket.find(params[:ticket_id])
  @booking = @ticket.ticket_bookings.build(booking_params)
  @booking.time = "#{booking_params["time_hours"]}:#{booking_params["time_minutes"]}"
  return redirect_to new_ticket_ticket_booking_path(ticket_id: @ticket.id), notice: 'Add Journey.' unless @booking.journey_location.present?
  return redirect_to new_ticket_ticket_booking_path(ticket_id: @ticket.id), notice: 'Select Seat Number.' unless @booking.seat_number.present?
  if @booking.save
    CustomMailer.custom_mailer(@ticket, @booking).deliver_now
    @booking.update(journey_date: @ticket.week_date.beginning_of_week + Date.parse(@booking.day).wday)
    redirect_to new_ticket_ticket_booking_path(ticket_id: @ticket.id), notice: 'Booking was successfully created.'
  else
    render :new
  end
end

  private

def booking_params
  params.require(:ticket_booking).require(:ticket_booking).permit(:time_hours, :time_minutes, :seat_number_option, :day, :journey_location, :seat_number)
end

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
