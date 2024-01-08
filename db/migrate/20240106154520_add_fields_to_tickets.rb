class AddFieldsToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :amount_paid, :decimal
    add_column :tickets, :extra_charges, :decimal
    add_column :tickets, :week_date, :date
  end
end
