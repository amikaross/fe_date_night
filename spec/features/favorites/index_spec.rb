require 'rails_helper'

describe 'Favorites Index' do 
  describe 'When I visit /favorites' do 
    describe 'As a logged in user' do 
      it 'displays my list of favorites' do 
        user = User.create(email: "amanda@example.com", password: "password")
        5.times do 
          create(:favorite, user: user)
        end
require 'pry'; binding.pry
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      end
    end
  end
end