class CreateTicketBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_bookings do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :day
      t.time :time
      t.text :journey_location
      t.string :journey_date
      t.string :date

      t.timestamps
    end
  end
end
