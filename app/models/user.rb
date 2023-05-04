class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true, email: true 
  validates_presence_of :password

  has_secure_password
end