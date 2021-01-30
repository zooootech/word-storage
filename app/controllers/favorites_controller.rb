class FavoritesController < ApplicationController
  before_action :set_word
  
  def create
    @favorite = Favorite.create(favorite_params))
    redirect_to user_path(current_user)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, word_id: @word.id)
    @favorite.destroy
    redirect_to user_path(current_user)
  end

  private
  def set_word
    @word = Word.find(params[:word_id])
  end

  def favorite_params
    params.require(:favorite).permit(user_id: current_user.id, word_id: @word.id)
  end
end
