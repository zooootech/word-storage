class Word < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :english
    validates :japanese
  end

  validates :english, format: {
    with:  /\A[a-zA-Z]+\z/, message: 'には半角アルファベットを使用してください'
  }, allow_blank: true
end
