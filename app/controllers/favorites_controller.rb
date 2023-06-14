class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
  end

  def create
    favorite = Favorite.new(user: current_user, google_id: params[:place_id], name: params[:name])
    favorite.save
    flash[:success] = "Successfully added #{favorite.name} to favorites!"
    redirect_to favorites_path
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.delete
    flash[:success] = "Successfully deleted #{favorite.name} from favorites!"

    redirect_to favorites_path
  end
end