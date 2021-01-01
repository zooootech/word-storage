class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :word

  # uniquenessヘルパーを用いて、モデルレベルで一意性をチェック
  # scopeオプションで、一意性チェックの範囲を限定する属性を指定
  validates :user_id, uniqueness: { scope: :word_id }
end
