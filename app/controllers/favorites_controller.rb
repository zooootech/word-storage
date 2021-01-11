class FavoritesController < ApplicationController
  def create
    @word = Word.find(params[:word_id])
    @favorite = Favorite.create(user_id: current_user.id, word_id: @word.id)
    redirect_to user_path(current_user)
  end

  def destroy
    @word = Word.find(params[:id])
    @favorite = Favorite.find_by(user_id: current_user.id, word_id: @word.id)
    @favorite.destroy
    redirect_to user_path(current_user)
  end
end
