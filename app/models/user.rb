class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true, email: true 
  validates_presence_of :password
  validate :fetch_lat_and_long, on: :update

  has_secure_password

  def fetch_lat_and_long
    converted_location = GeocodeService.convert_address_to_latlong(location)
    if converted_location
      self.lat, self.long = converted_location[:lat], converted_location[:lng]
    else
      errors.add(:location, "cannot be an invalid address")
    end
  end
end