class EmailNotification < ApplicationRecord
	validates :date, :time, :from_city, :to_city, :seat_number, :email, presence: true
end

