class Appointment < ApplicationRecord
  has_many :user_appointments, dependent: :destroy
  has_many :users, through: :user_appointments

  def formatted_time
    time.strftime("%I:%M %p")
  end

  def formatted_date
    date.strftime("%A, %B %-d, %Y")
  end

  def owner
    users.where(user_appointments: {owner: true}).first
  end
end