class TicketBooking < ApplicationRecord
  attr_accessor :time_hours, :time_minutes, :seat_number_option
  belongs_to :ticket
  validates :journey_location, presence: true
end
