ActiveAdmin.register Ticket do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :booked_by, :booked_count, :amount_paid, :extra_charges, :week_date, :booked_by_id, :booked_for_id, :week_number, :year
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :booked_by, :booked_count, :amount_paid, :extra_charges, :week_date, :booked_by_id, :booked_for_id, :week_number, :year]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
