require 'rails_helper'

describe UserAppointment, type: :model do 
  describe 'relationships' do 
    it { should belong_to(:user) }
    it { should belong_to(:appointment) }
  end
end