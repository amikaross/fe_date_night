class PlacesController < ApplicationController
  def index
    if params[:search_term]
      @results = google_service.search_place_by_keyword(params[:search_term])
    else
      @nearby_restaurants = google_service.list_nearby_places_of_type("restaurant")
    end
  end

  private

  def google_service
    GoogleService.new(current_user)
  end
end