class HomeController < ApplicationController
  def index
    @payment = Payment.order(updated_at: :desc).first
    # @owe_summary = calculate_owe_summary
    @owe_summary = HomeController.calculate_owe_summary
  end

  # private

  def self.calculate_owe_summary
    owe_summary = Hash.new(0)

    Ticket.all.each do |ticket|
      booked_by = ticket.booked_by
      booked_for = ticket.booked_for
      relationship = "Friends"
      # Calculate the total amount for this ticket, including extra charges
      if ticket.price_per_ticket == 85
        total_amount = ticket.booked_count * 85 + ticket.extra_charges
      else
        total_amount = ticket.booked_count * ticket.price_per_ticket + ticket.extra_charges
      end

      # Update the owe_summary hash based on the relationship
      if relationship == 'Friends'
        owe_summary[booked_by] -= total_amount
        owe_summary[booked_for] += total_amount
      elsif relationship == 'Colleagues'
        owe_summary[booked_by] += total_amount
        owe_summary[booked_for] -= total_amount
      end
    end

    Payment.all.each do |payment|
      owe_summary[payment.paid_by] -= payment.amount
      owe_summary[payment.paid_to] += payment.amount
    end
    owe_summary
  end
end
