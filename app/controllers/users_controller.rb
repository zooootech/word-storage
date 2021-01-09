class UsersController < ApplicationController
  def show
    @name = current_user.name
    @words = current_user.words.order(:english)
    favorite_words()
  end

  def favorite_words
    # 空の配列を作成
    @favorite_words = []
    # 現在ログインしているユーザーのお気に入りを変数に代入
    @favorites = current_user.favorites
    # 配列型式で格納されているお気に入り情報に対して繰り返し処理を行う
    @favorites.each do |favorite|
      # 繰り返し処理の中で、お気に入り情報の内、ワード情報のみを取り出し、配列の要素として追加
      @favorite_words << favorite.word
    end
    # 配列にsort_byメソッドを用いて、昇順（今回の場合、アルファベット順）に並び替え
    # 破壊的メソッド（!）を使用し、レシーバにあたるオブジェクト（今回の場合、@favorite_words）自身の値を変更
    @favorite_words.sort_by! do |a|
      a[:english]
    end
  end
end