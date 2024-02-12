class PaymentMailer < ApplicationMailer

  def payment_created_email(payment, owe_summary, current_user)
    @current_user = current_user
    @payment = payment
    @owe_summary = owe_summary
    @payment_by = User.find(@payment.paid_by_id)
    @payment_to = User.find(@payment.paid_to_id)
    @payment = Payment.order(updated_at: :desc).first 

    mail(to: @current_user.email, subject: 'Bus Ticket Manager | New Payment is Created-Modified')
    # mail(to: [@payment_to.email, @payment_by.email], subject: 'Bus Ticket Manager | New Payment is Created-Modified')
  end
end
