class FavoritesController < ApplicationController
  before_action :ensure_login, only: [:create, :destroy]

  def create
    favorite_params[:user_id] = current_user.id
    @favorite = Favorite.new(favorite_params)
    @favorite.save!

    if request.xhr?
      render json: {
        count: Favorite.fav_count(favorite_params[:artwork_id]),
        favid: @favorite.id
      }
    else
      redirect_to @artwork
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy

    if request.xhr?
      render json: {
        count: Favorite.fav_count(favorite_params[:artwork_id])
      }
    else
      redirect_to @artwork
    end
  end

  private
    def favorite_params
      params.permit(:user_id, :artwork_id)
    end
end
