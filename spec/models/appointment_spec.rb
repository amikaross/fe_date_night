require 'rails_helper'

describe Appointment, type: :model do 
  describe 'relationships' do 
    it { should have_many(:user_appointments) }
    it { should have_many(:users).through(:user_appointments) }
  end

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:place_name) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
  end
end