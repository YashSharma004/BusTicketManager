# app/admin/dashboard.rb
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      # First Row
      column do
        para "Welcome To Admin Dashboard"
        panel "Recent Tickets" do
          table_for Ticket.order("created_at desc").limit(2), class: "dashboard-table", style:"margin-bottom: 30px; margin-top: 30px;" do
            column("User") { |ticket| link_to(ticket.user.name, admin_user_path(ticket.user)) }
            column("Booked Count") { |ticket| ticket.booked_count }
            column("Date") { |ticket| ticket.week_date }
          end
        para "click on user to view more details"
        end
      end

      column do
        h5 'Ticket Booking Stats', class: "dashboard-heading"
        div do
          data = Ticket.joins(:user).group('users.name').count
          pie_chart data, height: '225px', library: { title: 'Tickets Booked by Each User' }
        end
      end
      column do
        para "Quick Look At Some Data"
        panel "Recent Payments" do
          table_for Payment.order("date desc").limit(2), class: "dashboard-table", style:"margin-bottom: 30px; margin-top: 30px;" do
            column("Paid By") { |payment| link_to(payment.paid_by.name, admin_user_path(payment.paid_by)) }
            column("Amount") { |payment| ("₹" + payment.amount.to_s) }
            column("Date") { |payment| payment.date }
          end
        para "click on paid by to view more details"
        end
      end

    end

    columns do
      # Second Row
      column do
        h5 'Amount Spent by Each User on Ticket', class: "dashboard-heading"
        div do
          data = Ticket.joins(:user).group('users.name').sum('(booked_count * price_per_ticket)')
          column_chart data, height: '300px', library: { title: 'Amount Spent by Each User' }, download: true, prefix: "₹"
        end
      end

      column do
        panel "Overall Ticket Stats" do
          data = Ticket.group_by_week(:created_at).sum(:booked_count)
          area_chart data, height: '300px', library: { title: 'Overall Tickets Booked' }
        end
      end


      column do
        # panel "Overall Spend of Each User in Payments" do
        h5 'Overall Spend of Each User in Payments'
        div do
          data = Payment.joins(:paid_by).group('users.name').sum(:amount)
          column_chart data, height: '300px', library: { title: 'Overall Spend of Each User in Payments' }, download: true, prefix: "₹"
        end
      end
      
    end

    columns do
      # Third Row
      column do
        panel "Overall Payments Made" do
          data = Payment.group_by_week(:date).sum(:amount)
          area_chart data, height: '300px', library: { title: 'Overall Payments Made' }
        end
      end

      column do
        h5 style: 'text-align: center; margin-bottom: 60px;' do "Overall Statistics" end
        div do
          para style: 'text-align: center;' do "Total Users: #{User.count}" end
          para style: 'text-align: center;' do "Total Ticket: #{Ticket.count}" end
          para style: 'text-align: center;' do "Total Payments: #{Payment.count}" end
          # para "Total Spend: ₹#{OrderHistory.sum(:total_price).to_i+Order.sum(:total_price).to_i}"
        end
      end
      column do
        panel "Overall Amount Spent" do
          data = Ticket.group_by_week(:created_at).sum('(booked_count * price_per_ticket)')
          area_chart data, height: '300px', library: { title: 'Overall Amount Spent' }, download: true, prefix: "₹"
        end
      end

    end
  end
end
