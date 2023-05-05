class PlacesController < ApplicationController
  def index
    @nearby_places = GoogleService.list_places_near(current_user)
  end
end