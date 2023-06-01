require 'rails_helper'

describe 'Favorites Index' do 
  describe 'When I visit /favorites' do 
    describe 'As a logged in user' do 
      before(:each) do 
        @user = User.create(email: "amanda@example.com", password: "password")
        5.times do 
          create(:favorite, user: @user)
        end

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      xit 'displays my list of favorites' do 

      end
    end
  end
end