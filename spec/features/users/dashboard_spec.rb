require 'rails_helper'

describe 'User Dashboard' do 
  describe 'When I visit my dashboard logged in as a valid user' do 
    it 'I see a request to fill in my location if I have not, which when filled out is replaced a link to explore nearby places' do
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

      expect(page).to have_link("Explore Nearby Places", href: places_path)
      expect(user.location).to eq('3220 N Williams St, Denver, CO 80205, USA')
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

      VCR.use_cassette('get_lat_long') do
        within('#edit_user_form') do 
          fill_in :location, with: '3220 N Williams St. Denver CO 80205'
          click_button 'Submit'
        end
      end

      expect(page).to_not have_content("Please enter your location")

      expect(page).to have_link("Explore Nearby Places", href: places_path)
      expect(user.location).to eq('3220 N Williams St, Denver, CO 80205, USA')
      expect(user.lat).to eq('39.7624957')
      expect(user.long).to eq('-104.9657181')
    end

    it 'shows me a link to logout' do 
      user = User.create(email: "amanda@example.com", password: "password")

      visit root_path 

      within('#login_form') do 
        fill_in 'email', with: 'amanda@example.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
      end

      expect(current_path).to eq(user_dashboard_path)
      expect(page).to have_link("Logout", href: session_path(user))
      click_link("Logout")

      expect(current_path).to eq(root_path)
      expect(page).to have_selector('#login_form')

      visit user_dashboard_path

      expect(page).to have_content("You must log in to view this page.")
      expect(current_path).to eq(root_path)
    end

    it 'shows a list of dates (both owned and unowned)' do 
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

      visit user_dashboard_path

      expect(page).to have_content("Your Dates:")
      within("#user_dates") do 
        expect(page).to have_content("#{user_created_app1.name}")
        expect(page).to have_content("#{user_created_app2.name}")
        expect(page).to have_content("#{user_invited_app1.name}")
        expect(page).to have_content("#{user_invited_app2.name}")
      end
    end

    it 'has a button to create a new date' do 
      user = User.create(email: "amanda@example.com", password: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_dashboard_path

      expect(page).to have_button("Create New Date")
    end
  end
end