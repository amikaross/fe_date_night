class User < ApplicationRecord
  has_many :user_dates
  has_many :dates, through: :user_dates
  has_many :favorites

  validates :email, uniqueness: true, presence: true, email: true 

  has_secure_password

  def update_location(user_params)
    if response = fetch_lat_and_long(user_params["location"])
      self.update(location: response[:formatted_address], lat: response[:lat_and_long][:lat], long: response[:lat_and_long][:lng])
    else
      errors.add(:location, "cannot be an invalid address")
      false
    end
  end

  def fetch_lat_and_long(location)
    GeocodeService.convert_address_to_latlong(location)
  end

  def created_dates
    require 'pry'; binding.pry
  end
end