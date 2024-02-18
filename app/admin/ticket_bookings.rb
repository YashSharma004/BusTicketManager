ActiveAdmin.register TicketBooking do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :ticket_id, :day, :time, :journey_location, :journey_date, :date, :seat_number
  #
  # or
  #
  # permit_params do
  #   permitted = [:ticket_id, :day, :time, :journey_location, :journey_date, :date, :seat_number]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
      f.inputs do
        f.input :ticket_id, :label => 'Ticket', :as => :select, :collection => Ticket.all.map{|ticket| ["#{ticket.week_date.strftime("%a, %d %b %Y")}", ticket.id]}
        f.input :time
        f.input :day
        f.input :journey_location
        f.input :journey_date
        f.input :date
        f.input :seat_number
      end
      f.actions
    end
  
end
