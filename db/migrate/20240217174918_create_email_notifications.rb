class CreateEmailNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :email_notifications do |t|
      t.date :date
      t.time :time
      t.string :from_city
      t.string :to_city
      t.string :seat_number
      t.string :email
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
