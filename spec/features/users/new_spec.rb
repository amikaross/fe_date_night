require 'rails_helper'

describe 'New User Page' do 
  before :each do 
    user = create(:user, email: 'amanda@example.com')
    visit new_user_path
  end

  it 'when form to register is submitted with correct info, a new user is created and you are redirected to login' do 
    expect(User.all.count).to eq(1)
    expect(page).to have_selector('#new_user_form')

    within('#new_user_form') do 
      fill_in 'email', with: 'delaney@example.com'
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'Register'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have successfully registered! Please log in below.")
    expect(User.all.count).to eq(2)
    expect(User.last.email).to eq('delaney@example.com')
  end
end