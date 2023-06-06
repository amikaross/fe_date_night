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

  it 'reloads the form, does not create new user, and flashes error if email has been taken' do 
    expect(User.all.count).to eq(1)

    within('#new_user_form') do 
      fill_in 'email', with: 'amanda@example.com'
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'Register'
    end

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("Email has already been taken")
    expect(User.all.count).to eq(1)
  end

  it 'reloads the form, does not create user, and flashes error if password is not valid' do 
    expect(User.all.count).to eq(1)

    within('#new_user_form') do 
      fill_in 'email', with: 'amanda@example.com'
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'pass'
      click_button 'Register'
    end

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(User.all.count).to eq(1)
  end

  it 'reloads the form, does not create user, and flashes error if email is not valid' do 
    expect(User.all.count).to eq(1)

    within('#new_user_form') do 
      fill_in 'email', with: 'asdfaskdjfd'
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'Register'
    end

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("Email is invalid")
    expect(User.all.count).to eq(1)
  end

  it 'reloads the form, does not create user, and flashes error if form is not filled out' do 
    expect(User.all.count).to eq(1)

    within('#new_user_form') do 
      click_button 'Register'
    end

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("Error: Email can't be blank, Password can't be blank")
    expect(User.all.count).to eq(1)
  end

  it 'sends a welcome email when a user successfully registers' do 
    within('#new_user_form') do 
      fill_in 'email', with: 'delaney@example.com'
      fill_in 'password', with: 'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'Register'
    end

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    email = ActionMailer::Base.deliveries.last

    expect(email.subject).to eq("Welcome to Date Night!")
    expect(email.from).to eq(["dateknight.info@gmail.com"])

    expect(email.text_part.body.to_s).to include("Hi delaney@example.com, we're so happy to have you.")

    expect(email.html_part.body.to_s).to include("Hi delaney@example.com, we're so happy to have you.")
  end
end