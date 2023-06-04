require 'rails_helper'

describe 'Appointment Show Page' do 
  describe 'As a logged in user' do 
    before(:each) do 
      @user = User.create(email: "amanda@example.com", password: "password", location: "3220 N Williams St, Denver, CO 80205, USA", lat: "39.7624957", long: "-104.9657181" )
      other_user = create(:user)
      # dates the user created
      @user_created_app1 = create(:appointment)
      @user_created_app2 = create(:appointment)
      # appointments the user is attending but did not create
      @user_invited_app1 = create(:appointment)
      @user_invited_app2 = create(:appointment)

      UserAppointment.create(user: @user, appointment: @user_created_app1, owner: true)
      UserAppointment.create(user: @user, appointment: @user_created_app2, owner: true)
      UserAppointment.create(user: @user, appointment: @user_invited_app1, owner: false)
      UserAppointment.create(user: @user, appointment: @user_invited_app2, owner: false)
      UserAppointment.create(user: other_user, appointment: @user_invited_app1, owner: true)
      UserAppointment.create(user: other_user, appointment: @user_invited_app2, owner: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe 'When I visit /appointments/:id' do 
      it 'displays the details for that particular appointment' do 
        visit appointment_path(@user_created_app1)

        expect(page).to have_content("#{@user_created_app1.name}'s Show Page")
        expect(page).to have_content(@user_created_app1.place_name)
        expect(page).to have_content(@user_created_app1.formatted_time)
        expect(page).to have_content(@user_created_app1.formatted_date)
        expect(page).to have_content(@user_created_app1.notes)


        visit appointment_path(@user_created_app2)

        expect(page).to have_content("#{@user_created_app2.name}'s Show Page")
        expect(page).to have_content(@user_created_app2.place_name)
        expect(page).to have_content(@user_created_app2.formatted_time)
        expect(page).to have_content(@user_created_app2.formatted_date)
        expect(page).to have_content(@user_created_app2.notes)
      end

      it 'has a button to edit if it is an appointment that is owned by the current user' do 
        visit appointment_path(@user_created_app1)
        
        expect(page).to have_button("Edit")

        visit appointment_path(@user_invited_app1)

        expect(page).to_not have_button("Edit")
      end

      it 'reflects any changes made after edit button is clicked' do 
        visit appointment_path(@user_created_app1)

        expect(page).to_not have_content("This is not a Date Name")
        expect(page).to_not have_content("These are not real notes.")

        click_button("Edit")

        expect(current_path).to eq(edit_appointment_path(@user_created_app1))

        fill_in(:name, with: "This is not a Date Name")
        fill_in(:notes, with: "These are not real notes.")
    
        click_button("Update")

        expect(current_path).to eq(appointment_path(@user_created_app1))
        expect(page).to have_content("This is not a Date Name")
        expect(page).to have_content("These are not real notes.")
      end
    end
  end
end