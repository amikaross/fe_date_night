require 'rails_helper'

describe 'The appointments index page' do 
  describe 'When you visit /appointments as a logged in user' do 
    it 'has a button to create a new date' do 
      user = User.create(email: "amanda@example.com", password: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit appointments_path

      expect(page).to have_button("Create New Date")
      click_button("Create New Date")
      expect(current_path).to eq(new_appointment_path)
    end

    it 'Shows a list of all the users dates, with buttons to view details and (if current_user is owner) delete' do 
      user = User.create(email: "amanda@example.com", password: "password", location: "3220 N Williams St, Denver, CO 80205, USA", lat: "39.7624957", long: "-104.9657181" )
      other_user = create(:user)
      # dates the user created
      user_created_app1 = create(:appointment, date: Date.today + 1)
      user_created_app2 = create(:appointment, date: Date.today - 1)
      # appointments the user is attending but did not create
      user_invited_app1 = create(:appointment, date: Date.today + 1)
      user_invited_app2 = create(:appointment, date: Date.today - 1)

      UserAppointment.create(user: user, appointment: user_created_app1, owner: true)
      UserAppointment.create(user: user, appointment: user_created_app2, owner: true)
      UserAppointment.create(user: user, appointment: user_invited_app1, owner: false, status: "accepted")
      UserAppointment.create(user: user, appointment: user_invited_app2, owner: false, status: "accepted")
      UserAppointment.create(user: other_user, appointment: user_invited_app1, owner: true)
      UserAppointment.create(user: other_user, appointment: user_invited_app2, owner: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit appointments_path

      expect(page).to have_content("Upcoming Dates")
      expect(page).to have_content("Archived Dates")

      within("#user_dates_upcoming") do 
        within("##{user_invited_app1.id}") do 
          expect(page).to have_content(user_invited_app1.name)
          expect(page).to have_button("View Details")
          expect(page).to_not have_button("Delete")
        end

        within("##{user_created_app1.id}") do 
          expect(page).to have_content(user_created_app1.name)
          expect(page).to have_button("View Details")
          expect(page).to have_button("Delete")

          click_button("Delete")
        end
        
        expect(current_path).to eq(appointments_path)

        user.reload
        visit appointments_path

        expect(page).to_not have_selector("##{user_created_app1.id}")
        expect(page).to_not have_content(user_created_app1.name)
      end

      within("#user_dates_archive") do 
        within("##{user_created_app2.id}") do 
          expect(page).to have_content(user_created_app2.name)
          expect(page).to have_button("View Details")
          expect(page).to have_button("Delete")
        end

        within("##{user_invited_app2.id}") do 
          expect(page).to have_content(user_invited_app2.name)
          expect(page).to have_button("View Details")
          expect(page).to_not have_button("Delete")
          click_button("View Details")
        end
      end

      expect(current_path).to eq(appointment_path(user_invited_app2.id))
    end

    it 'lists all *pending* invites, with buttons to accept or decline' do 
      user = User.create(email: "amanda@example.com", password: "password", location: "3220 N Williams St, Denver, CO 80205, USA", lat: "39.7624957", long: "-104.9657181" )
      other_user = create(:user)
 
      # appointments the user is invited to but has not accepted yet
      user_invited_app1 = create(:appointment, date: Date.today + 1)
      user_invited_app2 = create(:appointment, date: Date.today + 1)

      UserAppointment.create(user: user, appointment: user_invited_app1, owner: false, status: "pending")
      UserAppointment.create(user: user, appointment: user_invited_app2, owner: false, status: "pending")
      UserAppointment.create(user: other_user, appointment: user_invited_app1, owner: true)
      UserAppointment.create(user: other_user, appointment: user_invited_app2, owner: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit appointments_path

      within("#user_dates_upcoming") do 
        expect(page).to_not have_selector("##{user_invited_app2.id}")
      end

      within("#user_dates_pending") do 
        within("##{user_invited_app1.id}") do 
          expect(page).to have_content(user_invited_app1.name)
          expect(page).to have_button("View Details")
          expect(page).to have_button("Accept")
          expect(page).to have_button("Decline")
        end

        within("##{user_invited_app2.id}") do 
          expect(page).to have_content(user_invited_app2.name)
          expect(page).to have_button("View Details")
          expect(page).to have_button("Accept")
          expect(page).to have_button("Decline")

          click_button("Accept")
        end
      end

      expect(current_path).to eq(appointments_path)

      within("#user_dates_upcoming") do 
        within("##{user_invited_app2.id}") do 
          expect(page).to have_content(user_invited_app2.name)
          expect(page).to have_button("View Details")
          expect(page).to have_button("Decline")
        end
      end
    end
  end
end