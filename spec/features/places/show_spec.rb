require 'rails_helper'

describe "Places Show" do
  describe "As a logged in user when I visit /places/:place_id" do 
    before(:each) do 
      @user = User.create(email: "amanda@example.com", password: "password", location: "3220 N Williams St, Denver, CO 80205, USA", lat: "39.7624957", long: "-104.9657181" )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it "displays information about the place including name, hours, photo, summary" do 
      google_service = GoogleService.new(@user)

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

    it "has a button to add place to favorites" do 
      VCR.use_cassette('cart_driver_rino_show') do 
        visit place_path("ChIJBaRy7994bIcRq8oIj4xn9EU")

        click_button("Add To Favorites")

        expect(current_path).to eq(favorites_path)
        expect(page).to have_content("Successfully added Cart-Driver RiNo to favorites!")
      end
    end

    it "has a button to create date here" do 
      VCR.use_cassette('cart_driver_rino_show') do 
        visit place_path("ChIJBaRy7994bIcRq8oIj4xn9EU")

        click_button("Make it a date!")

        expect(current_path).to eq(new_appointment_path)

        within('#new_appointment_form') do 
          fill_in :name, with: 'Sat Night Movie'
          expect(page).to have_content("Place Name:")
          expect(page).to have_field(:place, disabled: true, with: "Cart-Driver RiNo")
          expect(page).to_not have_select(:place_info)
          fill_in :date, with: '2022/12/01'
          fill_in :time, with: '19:00'
          fill_in :notes, with: "This will be a good date."

          click_button 'Create Date'
        end

        expect(current_path).to eq(appointments_path)

        within("#user_dates_archive") do 
          click_button("View Details")
        end

        expect(page).to have_content("Cart-Driver RiNo")
      end
    end
  end
end