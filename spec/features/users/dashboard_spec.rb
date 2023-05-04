require 'rails_helper'

describe 'User Dashboard' do 
  describe 'When I visit my dashboard logged in as a valid user' do 
    it 'I see a request to fill in my location if I have not, which when filled out is replaced by a list of nearby places' do
      user = User.create(email: "amanda@example.com", password: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_dashboard_path

      expect(page).to have_content("Please enter your location")
      expect(page).to have_selector('#edit_user_form')
      expect(page).to_not have_selector('#nearby_places')
      VCR.use_cassette('get_lat_long') do
        within('#edit_user_form') do 
          fill_in :location, with: '3220 N Williams St. Denver CO 80205'
          click_button 'Submit'
        end
      end

      expect(page).to_not have_content("Please enter your location")
      expect(page).to_not have_selector('#edit_user_form')

      expect(page).to have_selector('#nearby_places')
      expect(user.location).to eq('3220 N Williams St. Denver CO 80205')
      expect(user.lat).to eq('39.7624957')
      expect(user.long).to eq('-104.9657181')
    end

    it 'if I input an address that does not return a valid lat and long, I see an error and the form to add address stays' do 
      user = User.create(email: "amanda@example.com", password: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_dashboard_path

      VCR.use_cassette('get_lat_long_error') do
        within('#edit_user_form') do 
          fill_in :location, with: 'amanda mika ross'
          click_button 'Submit'
        end
      end

      expect(page).to have_content("The address you entered is not valid, please try again.")

    end
  end
end