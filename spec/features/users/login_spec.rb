require 'rails_helper'

describe 'Login Page' do 
  before :each do 
    user = create(:user, email: 'amanda@example.com')
    visit '/'
  end

  describe 'As a visitor' do 
    it 'displays a form to enter my credentials, which when submitted redirects to my dashboard' do
      expect(page).to have_selector('#login_form')
      
      within('#login_form') do 
        fill_in 'email', with: 'amanda@example.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
      end
    end
  end
end