class Appointment < ApplicationRecord
  has_many :user_appointments
  has_many :users, through: :user_appointments

  def formatted_time
    time.strftime("%I:%M %p")
  end

  def formatted_date
    date.strftime("%A, %B %-d, %Y")
  end
end