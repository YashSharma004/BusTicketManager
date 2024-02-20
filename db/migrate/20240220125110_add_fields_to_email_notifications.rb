class AddFieldsToEmailNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :email_notifications, :bus_no, :string
    add_column :email_notifications, :boarding_location, :string
    add_column :email_notifications, :drop_location, :string
    add_column :email_notifications, :operator, :string
    add_column :email_notifications, :operator_contact, :string
  end
end
