require 'rails_helper'

describe 'Favorites Index' do 
  describe 'When I visit /favorites' do 
    describe 'As a logged in user' do 
      before(:each) do 
        @user = User.create(email: "amanda@example.com", password: "password")
        5.times do |n|
          create(:favorite, user: @user, google_id: n, name: "#{n} Place")
        end

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'displays my list of favorites' do 
        visit favorites_path
      
        expect(page).to have_link("0 Place", href: place_path(0))
        expect(page).to have_link("1 Place", href: place_path(1))
        expect(page).to have_link("2 Place", href: place_path(2))
        expect(page).to have_link("3 Place", href: place_path(3))
        expect(page).to have_link("4 Place", href: place_path(4))
      end

      it 'has a button to delete each favorite' do 
        visit favorites_path

        5.times do |n|
          within("##{n}") do 
            expect(page).to have_button("Remove")
          end
        end

        within("#0") do 
          click_button("Remove")
        end

        expect(current_path).to eq(favorites_path)

        within("#flash-messages") do
          expect(page).to have_content("Successfully deleted 0 Place from favorites!")
        end
        
        @user.reload
        visit favorites_path
        expect(page).to_not have_selector("#0")
      end
    end
  end
end