require 'rails_helper'

describe User, type: :model do 
  describe 'validations' do 
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }
  end

  describe 'relationships' do 
    it { should have_many(:appointments).through(:user_appointments) }
    it { should have_many(:favorites) }
  end

  describe 'instance methods' do
     # primary user
    let(:user) { create(:user) }
    # another user we're not interested in
    let(:other_user) { create(:user) }
    # dates the user created
    let(:user_created_app1) { create(:appointment) }
    let(:user_created_app2) { create(:appointment) }
    # appointments the user is attending but did not create
    let(:user_invited_app1) { create(:appointment) }
    let(:user_invitied_app2) { create(:appointment) }

    before(:each) do 
      UserAppointment.create(user: user, appointment: user_created_app1, owner: true)
      UserAppointment.create(user: user, appointment: user_created_app2, owner: true)
      UserAppointment.create(user: user, appointment: user_invited_app1, owner: false)
      UserAppointment.create(user: user, appointment: user_invitied_app2, owner: false)
      UserAppointment.create(user: other_user, appointment: user_invited_app1, owner: true)
      UserAppointment.create(user: other_user, appointment: user_invitied_app2, owner: true)
      # appointments not associated with user at all 
      5.times { create(:appointment) }
    end

    describe '#created_appointments' do 
      it 'returns only the appointments created by that user' do 
        expect(Appointment.all.count).to eq(9)
        expect(user.appointments.count).to eq(4)
        expect(user.created_appointments).to eq([user_created_app1, user_created_app2])
      end
    end
  end
end