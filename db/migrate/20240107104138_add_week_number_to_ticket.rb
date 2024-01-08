class AddWeekNumberToTicket < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :week_number, :string
    add_column :tickets, :year, :string
  end
end
