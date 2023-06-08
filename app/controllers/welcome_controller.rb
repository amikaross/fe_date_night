class WelcomeController < ApplicationController 
  def index 
    redirect_to user_dashboard_path if current_user
  end
end