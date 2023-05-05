require 'rails_helper'

describe "Places Index" do 
  describe "As a logged in user when I visit /places" do 
    it "displays a list of places nearby my set location" do
      user = User.create(email: "amanda@example.com", password: "password", location: "3220 N Williams St, Denver, CO 80205, USA", lat: "39.7624957", long: "-104.9657181" )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      VCR.use_cassette('get_places_near_cole') do 
        visit "/places"
      end
    
      expect(page).to have_content("Mercury Cafe")
    save_and_open_page
    end
  end
end