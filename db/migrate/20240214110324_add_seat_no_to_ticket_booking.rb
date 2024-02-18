class AddSeatNoToTicketBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :ticket_bookings, :seat_number, :string
  end
end
