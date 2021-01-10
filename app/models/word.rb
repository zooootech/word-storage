class Word < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user

  with_options presence: true do
    validates :english
    validates :japanese
  end

  validates :english, format: {
    with:  /\A[a-zA-Z]+\z/, message: 'には半角アルファベットを使用してください'
  }, allow_blank: true

  # データに対する処理などを行うプログラム処理（＝ビジネスロジック）は、モデルに置く
  # クラスメソッド（クラスで共通の情報を使った処理）は、メソッド名の前にselfを.(ドット)で繋げて定義
  def self.search_english(search)
    # 検索フォームに何か値が入力されていた場合
    if search != ""
      Word.where('english LIKE(?)', "%#{search}%")
    else
      Word.all.order(:english)
    end
  end

  def self.search_japanese(search)
    if search != ""
      Word.where('japanese LIKE(?)', "%#{search}%")
    else
      Word.all.order(:english)
    end
  end

  def self.search_remarks(search)
    if search != ""
      Word.where('remarks LIKE(?)', "%#{search}%")
    else
      Word.all.order(:english)
    end
  end
end
