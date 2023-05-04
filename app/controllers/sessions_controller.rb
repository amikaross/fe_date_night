class SessionsController < ApplicationController 
  def create 
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login Successful!"
      redirect_to user_dashboard_path
    else 
      flash[:error] = "Sorry, your credentials are bad!"
      redirect_to root_path
    end
  end
end