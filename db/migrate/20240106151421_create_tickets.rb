class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :booked_by
      t.integer :booked_count

      t.timestamps
    end
  end
end
