class CreateMakeMyTripBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :make_my_trip_bookings do |t|
      t.string :boarding_location
      t.string :drop_location
      t.date :date

      t.timestamps
    end
  end
end
