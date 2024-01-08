class TicketMailer < ApplicationMailer
  # default from: 'yashsharma0787@gmail.com' # Replace with your email address

  def ticket_created_email(ticket, owe_summary)
    @ticket = ticket
    @owe_summary = owe_summary
    @user_booked_by = User.find(@ticket.booked_by_id)
    @user_booked_for = User.find(@ticket.booked_for_id)
    @payment = Payment.order(updated_at: :desc).first 

    mail(to: [@user_booked_by.email, @user_booked_for.email], subject: 'Ticket Created/Updated')
  end
end
