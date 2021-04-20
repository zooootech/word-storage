class UsersController < ApplicationController
  def show
    @name = current_user.name
    @words = current_user.words.order(:english)

    # Favoriteモデルに定義されているメソッドを呼び出し、変数に代入
    # @favorite_words = Favorite.favorite_words(current_user)

    @favorite_words = current_user.fav_words.sort_by { |a| [a[:english].downcase, a[:english]] }
  end
end
