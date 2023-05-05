class PlacesController < ApplicationController
  def index
    @nearby_restaurants = GoogleService.list_places_near(current_user, "restaurant")
  end
end