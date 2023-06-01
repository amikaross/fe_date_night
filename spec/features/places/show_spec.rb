require 'rails_helper'

describe "Places Show" do
  describe "As a logged in user when I visit /places/:place_id" do 
    it "displays information about the place including name, hours, photo, summary" do 
      user = User.create(email: "amanda@example.com", password: "password", location: "3220 N Williams St, Denver, CO 80205, USA", lat: "39.7624957", long: "-104.9657181" )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      google_service = GoogleService.new(user)

      VCR.use_cassette('cart_driver_rino_show') do 
        cart_driver = google_service.get_place_by_id("ChIJBaRy7994bIcRq8oIj4xn9EU")

        visit place_path("ChIJBaRy7994bIcRq8oIj4xn9EU")

        expect(page).to have_content(cart_driver.name)
        cart_driver.hours_array.each do |hour|
          expect(page).to have_content(hour)
        end
        expect(page).to have_content(cart_driver.summary)
        expect(page).to have_content(cart_driver.phone)
        expect(page).to have_content(cart_driver.address)
        expect(page).to have_content(cart_driver.rating)
      end
    end

    it "has a button to add to favorites" do 
      user = User.create(email: "amanda@example.com", password: "password", location: "3220 N Williams St, Denver, CO 80205, USA", lat: "39.7624957", long: "-104.9657181" )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette('cart_driver_rino_show') do 
        visit place_path("ChIJBaRy7994bIcRq8oIj4xn9EU")

        click_link("Add To Favorites")

        expect(current_path).to eq(place_path("ChIJBaRy7994bIcRq8oIj4xn9EU"))
        expect(page).to have_content("Successfully added Cart-Driver RiNo to favorites!")
      end
    end
  end
end