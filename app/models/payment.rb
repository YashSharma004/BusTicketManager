class Payment < ApplicationRecord
  after_create :send_payment_created_email
  after_update :send_payment_created_email
  # belongs_to :paid_by
  # belongs_to :paid_to
  # belongs_to :booked_by, class_name: 'User', foreign_key: 'booked_by_id', optional: true
  belongs_to :paid_by, class_name: 'User', foreign_key: 'paid_by_id'
  belongs_to :paid_to, class_name: 'User', foreign_key: 'paid_to_id'
 
  private
  def send_payment_created_email
    PaymentMailer.payment_created_email(self).deliver_now
  end
end
