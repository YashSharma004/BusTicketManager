ActiveAdmin.register EmailNotification do
  permit_params :date, :time, :from_city, :to_city, :seat_number, :email, :subject, :bus_no, :boarding_location, :drop_location, :message, :operator, :operator_contact

  form do |f|
    f.inputs "Email Notification Details" do
      f.input :date, as: :datepicker
      f.input :time      
      f.input :from_city, as: :select, collection: ["Ujjain", "Indore", "Other"]#, input_html: { class: 'from-city-select' }
      # f.input :custom_from_city, label: 'Custom City', input_html: { class: 'custom-from-city-input', style: 'display: none;' }
      f.input :to_city ,as: :select, collection: ["Ujjain", "Indore", "Other"]
      # f.input :custom_from_city, label: 'Custom City', input_html: { class: 'custom-from-city-input', style: 'display: none;' }
      f.input :seat_number, as: :select, collection: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', 'A1', 'A2', 'A3', 'A4', 'B1', 'B2', 'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 'D1', 'D2', 'D3', 'D4', 'E1', 'E2', 'E3', 'E4', 'F1', 'F2', 'F3', 'F4', 'G1', 'G2', 'G3', 'G4', 'H1', 'H2', 'H3', 'H4', 'I1', 'I2', 'I3', 'I4', 'J1', 'J2', 'J3', 'J4', 'K1', 'K2', 'K3', 'K4', 'L1', 'L2', 'L3', 'L4', 'M1', 'M2', 'M3', 'M4', 'N1', 'N2', 'N3', 'N4', 'O1', 'O2', 'O3', 'O4', 'P1', 'P2', 'P3', 'P4', 'Q1', 'Q2', 'Q3', 'Q4', 'R1', 'R2', 'R3', 'R4', 'S1', 'S2', 'S3', 'S4', 'T1', 'T2', 'T3', 'T4', 'U1', 'U2', 'U3', 'U4', 'V1', 'V2', 'V3', 'V4', 'W1', 'W2', 'W3', 'W4', 'X1', 'X2', 'X3', 'X4', 'Y1', 'Y2', 'Y3', 'Y4', 'Z1', 'Z2', 'Z3', 'Z4']

      f.input :email, :label => 'Email', :as => :select, :collection => User.all.map{|user| ["#{user.name}", user.email]}
      f.input :subject, :label => 'Email Type', as: :select, collection: ['Reminder', 'Other']
      f.input :bus_no
      f.input :boarding_location, as: :select, collection: ["Shanti Palace", "Nanakheda", "Vijay Nagar", "AICTSL Campus"]
      f.input :drop_location, as: :select, collection: ["Shanti Palace", "Nanakheda", "Vijay Nagar", "AICTSL Campus"]
      # f.input :message
      f.input :operator, as: :select, collection: ["Royal Travels", "Other"]
      f.input :operator_contact, as: :select, collection: ["Royal Travels Indore: 0734-4027999, 7342533822, 9111992222", "Royal Travels Ujjain: 0734-2533822", "Not Known"]
    end
    f.actions
  end
  controller do
    def create
      super do |format|
        if resource.valid?
          EmailNotificationMailer.email_notification(resource).deliver_now
        end
      end
    end
    def update
      super do |format|
        if resource.valid?
          EmailNotificationMailer.email_notification(resource).deliver_now
        end
      end
    end
  end
end
