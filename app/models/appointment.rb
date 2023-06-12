class Appointment < ApplicationRecord
  has_many :user_appointments, dependent: :destroy
  has_many :users, through: :user_appointments

  validates :name, :place_name, :date, :time, presence: true

  before_save :get_date_time

  def formatted_time
    time.strftime("%I:%M %p")
  end

  def formatted_date
    date.strftime("%A, %B %-d, %Y")
  end

  def get_date_time
    self.timestamp = date.to_datetime.change(hour: time.hour, min: time.min, sec: time.sec)
  end

  def owner
    users.where(user_appointments: {owner: true}).first
  end
end