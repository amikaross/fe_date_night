require 'rails_helper'

describe Appointment, type: :model do 
  describe 'relationships' do 
    it { should have_many(:user_appointments) }
    it { should have_many(:users).through(:user_appointments) }
  end
end