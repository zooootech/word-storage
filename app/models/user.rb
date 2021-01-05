class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:name] # 認証のキーをメールから名前へ

  has_many :words, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_words, through: :favorites, source: :word

  validates_uniqueness_of :name
  validates_presence_of :name

  # nameを利用してログイン（ユーザー名で検索）
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["name = :value", { :value => name }]).first
    else
      where(conditions).first
    end
  end

  # 登録時に email を不要にする
  def email_required?
    false
  end

  def email_changed?
    false
  end

  # 「Undefined method will_save_change_to_email?」エラーを防ぐ為に以下を記述
  def will_save_change_to_email?
    false
  end
end
