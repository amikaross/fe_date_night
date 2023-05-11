class AppointmentsController < ApplicationController
  def new 
    if !current_user
      flash[:error] = "You must log in to view this page."
      redirect_to root_path
    end
  end
end