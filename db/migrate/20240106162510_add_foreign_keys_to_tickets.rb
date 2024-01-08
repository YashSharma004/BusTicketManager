class AddForeignKeysToTickets < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :booked_by, foreign_key: { to_table: :users }, null: false
    add_reference :tickets, :booked_for, foreign_key: { to_table: :users }, null: false
  end
end
