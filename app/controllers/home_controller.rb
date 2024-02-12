class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @payments = Payment.where("paid_to_id = ? OR paid_by_id = ?", current_user.id, current_user.id).order(updated_at: :desc)
    @payment = @payments.order(updated_at: :desc).first
    # @payment = Payment.order(updated_at: :desc).first
    # @owe_summary = calculate_owe_summary
    @owe_summary = HomeController.calculate_owe_summary(current_user)
  end

  # def self.calculate_owe_summary
  #   owe_summary = Hash.new(0)

  #   Ticket.all.each do |ticket|
  #     booked_by = ticket.booked_by
  #     booked_for = ticket.booked_for
  #     relationship = "Friends"
  #     if ticket.price_per_ticket == 85
  #       total_amount = ticket.booked_count * 85 + ticket.extra_charges
  #     else
  #       total_amount = ticket.booked_count * ticket.price_per_ticket + ticket.extra_charges
  #     end

  #     if relationship == 'Friends'
  #       owe_summary[booked_by] -= total_amount
  #       owe_summary[booked_for] += total_amount
  #     elsif relationship == 'Colleagues'
  #       owe_summary[booked_by] += total_amount
  #       owe_summary[booked_for] -= total_amount
  #     end
  #   end

  #   Payment.all.each do |payment|
  #     owe_summary[payment.paid_by] -= payment.amount
  #     owe_summary[payment.paid_to] += payment.amount
  #   end
  #   owe_summary
  # end
  def self.calculate_owe_summary(current_user)
    owe_summary = Hash.new(0)

    Ticket.where("booked_by_id = ? OR booked_for_id = ?", current_user.id, current_user.id).each do |ticket|
      total_amount = ticket.booked_count * ticket.price_per_ticket + ticket.extra_charges

      if ticket.booked_by_id == current_user.id
        owe_summary[ticket.booked_for_id] += total_amount
      elsif ticket.booked_for_id == current_user.id
        owe_summary[ticket.booked_by_id] -= total_amount
      end
    end

    Payment.where("paid_by_id = ? OR paid_to_id = ?", current_user.id, current_user.id).each do |payment|
      if payment.paid_by_id == current_user.id
        owe_summary[payment.paid_to_id] += payment.amount
      elsif payment.paid_to_id == current_user.id
        owe_summary[payment.paid_by_id] -= payment.amount
      end
    end

    owe_summary.reject! { |_, value| value.zero? }

    owe_summary
  end
end
