class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
  end

  def create
    favorite = Favorite.new(user: current_user, google_id: params[:place_id], name: params[:name])
    if favorite.save
      flash[:success] = "Successfully added #{favorite.name} to favorites!"
      redirect_to favorites_path
    else 
      flash[:error] = "Something went wrong!"
      redirect_to place_path(params[:place_id])
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    if favorite
      favorite.delete
      flash[:success] = "Successfully deleted #{favorite.name} from favorites!"
    else
      flash[:error] = "Something went wrong!"
    end
    redirect_to favorites_path
  end
end