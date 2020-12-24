class FavoritesController < ApplicationController
  def create
    # @user = current_user.id
    @user = User.find(params[:user_id])
    @artwork = Artwork.find(params[:artwork_id])
    favorites = {user_id: @user.id, artwork_id: @artwork.id}
    @favorite = Favorite.new(favorites)
    @favorite.save!
    
    if request.xhr?
      favs = Favorite.where(artwork_id: params[:artwork_id])
      render json: {
        count: favs.count,
        favid: @favorite.id
      }
    else
      redirect_to @artwork
    end
  end
  
  def destroy
    Favorite.find(params[:id]).destroy
    
    if request.xhr?
      favs = Favorite.where(artwork_id: params[:artwork_id])
      render json: {
        count: favs.count
      }
    else
      redirect_to @artwork
    end
  end
end
