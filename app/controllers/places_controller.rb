class PlacesController < ApplicationController
  def index
    if current_user.location == nil 
      flash[:error] = "Error: You must fill in your current location."
      redirect_to user_dashboard_path
    else
      if params[:search_term]
        @results = google_service.search_place_by_keyword(params[:search_term])
      else
        @results = google_service.list_nearby_places_of_type("restaurant")
      end
    end
  end

  private

  def google_service
    GoogleService.new(current_user)
  end
end