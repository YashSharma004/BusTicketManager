class AddPricePerTicketToTicket < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :price_per_ticket, :decimal, default: 85
  end
end
