class Payment < ApplicationRecord
  # after_create :send_payment_created_email
  # after_update :send_payment_created_email

  belongs_to :paid_by, class_name: 'User', foreign_key: 'paid_by_id'
  belongs_to :paid_to, class_name: 'User', foreign_key: 'paid_to_id'
 
  # private
  def send_payment_created_email(current_user)
    paid_by = User.find(self.paid_by_id)
    paid_to = User.find(self.paid_to_id)
    PaymentMailer.payment_created_email(self, HomeController.calculate_owe_summary(paid_by), paid_by).deliver_now
    PaymentMailer.payment_created_email(self, HomeController.calculate_owe_summary(paid_to), paid_to).deliver_now
    # PaymentMailer.payment_created_email(self, HomeController.calculate_owe_summary(current_user), current_user).deliver_now
  end
end
