class User < ApplicationRecord
  has_many :user_appointments
  has_many :appointments, through: :user_appointments
  has_many :favorites

  validates :email, uniqueness: true, presence: true, email: true 

  scope :all_except, ->(user) { where.not(id: user) }

  has_secure_password

  def upcoming_appointments
    appointments.where("timestamp > ?", Time.now.change(offset: "+0000"))
  end

  def past_appointments
    appointments.where("timestamp < ?", Time.now.change(offset: "+0000"))
  end

  def update_location(user_params)
    if response = fetch_lat_and_long(user_params["location"])
      self.update(location: response[:formatted_address], lat: response[:lat_and_long][:lat], long: response[:lat_and_long][:lng])
    else
      errors.add(:location, "cannot be an invalid address")
      false
    end
  end

  def service
    GoogleService.new(self)
  end

  def fetch_lat_and_long(location)
    service.convert_address_to_latlong(location)
  end

  def owned_appointments
    apps = appointments.where(user_appointments: {owner: true})
  end

  def unowned_appointments
    appointments.where(user_appointments: {owner: false})
  end
end