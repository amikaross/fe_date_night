class UsersController < ApplicationController
  def show 
    if !current_user
      flash[:error] = "You must log in to view this page."
      redirect_to root_path
    end
  end

  def new 
  end

  def create
    user = User.new(user_params)
    if user.save
      UserNotifierMailer.welcome(user).deliver_now
      flash[:success] = "You have successfully registered! Please log in below."
      redirect_to root_path
    else
      flash[:error] = "Error: #{error_message(user.errors)}"
      redirect_to new_user_path
    end
  end

  def update
    if current_user.update_location(user_params)
      flash[:success] = "You have successfully added your address!"
    else
      flash[:error] = "The address you entered is not valid, please try again."
    end
    redirect_to user_dashboard_path
  end

  private

    def user_params
      params.permit(:email, :password, :password_confirmation, :location)
    end
end