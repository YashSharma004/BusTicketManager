class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :booked_tickets, class_name: 'Ticket', foreign_key: 'booked_by_id', dependent: :destroy
  has_many :received_tickets, class_name: 'Ticket', foreign_key: 'booked_for_id', dependent: :destroy

  enum relationship: { friends: 'Friends', colleagues: 'Colleagues' }
  validates :name, presence: true
  before_save :customize_name

  private
  def customize_name
    customized_name = self.name.downcase
    name_array = customized_name.split(" ")
    if name_array.size >= 2
      self.name = "#{name_array.first.capitalize} #{name_array.last.capitalize}"
    else
      self.name = "#{name_array.first.capitalize}"
    end
  end
end
