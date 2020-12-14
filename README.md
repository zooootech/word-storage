## usersテーブル

| Column             | Type   | Options                        |
| ------------------ | ------ | ------------------------------ |
| name               | string | null: false                    |
| encrypted_password | string | null: false                    |

### Association
- has_many :words
- has_many :favorites
<!-- 既にuserとwordで一対多の関係を作っている為、has_many :postsがある状態
この状態で、お気に入り用のhas_many :wordsを作ろうとすると、名前がまったく同じであるためエラーになってしまう
そのため、お気に入り機能ではpostsではなく別の名前を与えてあげる必要がある -->
<!-- sourceでどのテーブルを参照するのかを指定 -->
- has_many :fav_words, through: :favorites, source: :word

## wordsテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| english  | string     | null: false                    |
| japanese | string     | null: false                    |
| remarks  | string     |                                |
| user_id  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :favorites
- has_many :users, through: :favorites

## favoritesテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| word_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :word