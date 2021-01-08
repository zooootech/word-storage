class UsersController < ApplicationController
  def show
    @name = current_user.name
    @words = current_user.words.order(:english)
    favorite_words()
  end

  def favorite_words
    @favorite_words = []
    @favorites = current_user.favorites
    @favorites.each do |favorite|
      @favorite_words << favorite.word
    end
    # 配列にsort_byメソッドを用いて、昇順（今回の場合、アルファベット順）に並び替え
    # 破壊的メソッド（!）を使用し、レシーバにあたるオブジェクト（今回の場合、@favorite_words）自身の値を変更
    @favorite_words.sort_by! do |a|
      a[:english]
    end
  end
end