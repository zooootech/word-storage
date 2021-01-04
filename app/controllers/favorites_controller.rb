class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.create(like_params)
  end

  private

  def like_params
    @word = Word.find(params[:id])
    params.require(:favorite).merge(user_id: current_user.id, word_id: @word.id)
  end

end
