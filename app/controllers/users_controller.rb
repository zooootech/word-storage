class UsersController < ApplicationController
  def show
    @name = current_user.name
    @words = current_user.words.order(:english)
    @favorite_words = Favorite.favorite_words(current_user)
  end
end