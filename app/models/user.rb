class User < ApplicationRecord
  has_many :booked_tickets, class_name: 'Ticket', foreign_key: 'booked_by_id', dependent: :destroy
  has_many :received_tickets, class_name: 'Ticket', foreign_key: 'booked_for_id', dependent: :destroy

  enum relationship: { friends: 'Friends', colleagues: 'Colleagues' }
end
