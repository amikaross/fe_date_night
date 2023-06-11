require 'rails_helper'

describe 'New Appointments Page' do 
  describe 'If I visit /appointments/new as a logged-in user' do 
    it 'shows me a form to create a new appointment' do 
      user = User.create(email: "amanda@example.com", password: "password")
      user.favorites.create(google_id: 1234567, name: "The first favorite")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_appointment_path

      expect(page).to have_selector('#new_appointment_form')

      within('#new_appointment_form') do 
        fill_in :name, with: 'Sat Night Movie'
        select 'The first favorite', from: :place_info
        fill_in :date, with: '2022/12/01'
        fill_in :time, with: '19:00'
        fill_in :notes, with: "This will be a good date."
        click_button 'Create Date'
      end

      expect(current_path).to eq(appointments_path)
      
      within("#user_dates_archive") do 
        expect(page).to have_content("Sat Night Movie")
      end

      date = Appointment.last 

      expect(date.place_id).to eq("1234567")
      expect(date.place_name).to eq("The first favorite")
    end

    it 'has a selector for any favorites that ive created instead of filling in place_name myself' do 
      user = User.create(email: "amanda@example.com", password: "password")
      user.favorites.create(google_id: 1234567, name: "The first favorite")
      user.favorites.create(google_id: 2345678, name: "The second favorite")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_appointment_path

      within('#new_appointment_form') do 
        expect(page).to have_select(:place_info, options: ["The first favorite", "The second favorite"])
      end
    end
  end

  describe 'If I visit /appointments/new when I have not logged in' do 
    it 'displays an error and redirects me to the home page' do 
      visit new_appointment_path

      expect(page).to have_content("You must log in to view this page.")
      expect(current_path).to eq(root_path)
    end
  end
end