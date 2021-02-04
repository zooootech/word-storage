class Word < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user

  with_options presence: true do
    validates :english
    validates :japanese
  end

  validates :english, format: {
    with: /\A[a-zA-Z_.,\s]+\z/, message: 'には、半角アルファベット、_(アンダースコア)、.(ドット)、,(カンマ)、半角スペースのみ使用してください'
  }, allow_blank: true

  # validates :english, format: {
  #   with: /\A[a-zA-Z]{1,}[_.,\s]+\z/, message: "には、半角アルファベット、_(アンダースコア)、.(ドット)、,(カンマ)、半角スペースのみ使用し、最低1文字以上のアルファベットを入力してください"
  # }, allow_blank: true

  # データに対する処理などを行うプログラム処理（＝ビジネスロジック）は、モデルに置く
  # クラスメソッド（クラスで共通の情報を使った処理）は、メソッド名の前にselfを.(ドット)で繋げて定義
  def self.search_english(search)
    # 検索フォームに何か値が入力されていた場合
    if search != ''
      # モデル.where('検索対象となるカラムを含む条件式')で、「条件に一致したレコードのインスタンス」を配列の形で取得する
      # LIKE句は、曖昧（あいまい）な文字列の検索をするときに使用し、例えば、where('title LIKE(?)', "%a%")とすることで、「aが含まれるタイトル」を意味する
      Word.where('english LIKE(?)', "%#{search}%").order(:english)
    else
      Word.all.order(:english).order(:japanese)
    end
  end

  def self.search_japanese(search)
    if search != ''
      Word.where('japanese LIKE(?)', "%#{search}%").order(:english).order(:japanese)
    else
      Word.all.order(:english).order(:japanese)
    end
  end

  def self.search_remarks(search)
    if search != ''
      Word.where('remarks LIKE(?)', "%#{search}%").order(:english).order(:japanese)
    else
      Word.all.order(:english).order(:japanese)
    end
  end
end
