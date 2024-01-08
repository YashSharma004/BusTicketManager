class PaymentMailer < ApplicationMailer

  def payment_created_email(payment)
    @payment = payment
    # @owe_summary = owe_summary
    @payment_by = User.find(@payment.paid_by_id)
    @payment_to = User.find(@payment.paid_to_id)
    @payment = Payment.order(updated_at: :desc).first 

    mail(to: [@payment_to.email, @payment_by.email], subject: 'Payment Created/Updated')
  end
end
