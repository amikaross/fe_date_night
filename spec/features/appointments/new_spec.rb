require 'rails_helper'

describe 'New Appointments Page' do 
  describe 'If I visit /appointments/new as a logged-in user' do 
    it 'shows me a form to create a new appointment' do 
      user = User.create(email: "amanda@example.com", password: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_appointment_path

      expect(page).to have_selector('#new_appointment_form')

      within('#new_appointment_form') do 
        fill_in :name, with: 'Sat Night Movie'
        fill_in :place_name, with: 'The house'
        fill_in :date, with: '2022/12/01'
        fill_in :time, with: '19:00'
        fill_in :notes, with: "This will be a good date."
        click_button 'Create Date'
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