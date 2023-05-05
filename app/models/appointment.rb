class Appointment < ApplicationRecord
  has_many :user_appointments
  has_many :users, through: :user_appointments
end