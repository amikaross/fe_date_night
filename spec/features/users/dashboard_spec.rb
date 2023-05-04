require 'rails_helper'

describe 'User Dashboard' do 
  describe 'When I visit my dashboard logged in as a valid user' do 
    it 'I see a request to fill in my location if I have not, which when filled out is replaced by a search places bar' do
      user = User.create(email: "amanda@example.com", password: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_dashboard_path

      expect(page).to have_content("Please enter your location")
      expect(page).to have_selector('#edit_user_form')
      within('#edit_user_form') do 
        fill_in :location, with: '3220 N Williams St. Denver CO 80205'
        click_button 'Submit'
      end

      expect(page).to_not have_content("Please enter your location")
    end
  end
end