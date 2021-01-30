class FavoritesController < ApplicationController
  before_action :set_word
  
  def create
    @favorite = Favorite.create(user_id: current_user.id, word_id: @word.id)
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


end
