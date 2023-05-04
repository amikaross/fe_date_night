class UsersController < ApplicationController
  def show 
  end

  def new 
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "You have successfully registered! Please log in below."
      redirect_to root_path
    else
      flash[:error] = "Error: #{error_message(user.errors)}"
      redirect_to new_user_path
    end
  end

  private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end