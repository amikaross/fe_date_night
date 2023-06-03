require 'rails_helper'

describe 'The appointments index page' do 
  describe 'When you visit /appointments as a logged in user' do 
    it 'Shows a list of all the users dates, which are links to each dates show page' do 
      user = User.create(email: "amanda@example.com", password: "password", location: "3220 N Williams St, Denver, CO 80205, USA", lat: "39.7624957", long: "-104.9657181" )
      other_user = create(:user)
      # dates the user created
      user_created_app1 = create(:appointment)
      user_created_app2 = create(:appointment)
      # appointments the user is attending but did not create
      user_invited_app1 = create(:appointment)
      user_invited_app2 = create(:appointment)

      UserAppointment.create(user: user, appointment: user_created_app1, owner: true)
      UserAppointment.create(user: user, appointment: user_created_app2, owner: true)
      UserAppointment.create(user: user, appointment: user_invited_app1, owner: false)
      UserAppointment.create(user: user, appointment: user_invited_app2, owner: false)
      UserAppointment.create(user: other_user, appointment: user_invited_app1, owner: true)
      UserAppointment.create(user: other_user, appointment: user_invited_app2, owner: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit appointments_path

      expect(page).to have_content("Your Dates:")

      within("#user_dates") do 
        expect(page).to have_link("#{user_created_app1.name}", href: appointment_path(user_created_app1))
        expect(page).to have_link("#{user_created_app2.name}", href: appointment_path(user_created_app2))
        expect(page).to have_link("#{user_invited_app1.name}", href: appointment_path(user_invited_app1))
        expect(page).to have_link("#{user_invited_app2.name}", href: appointment_path(user_invited_app2))
      end
    end
  end
end