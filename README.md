# WordStorage
<font size=3>〜プログラミング学習者向け単語帳アプリ〜<font>

# 概要
備忘録として、英語とその意味を登録することができるアプリケーションです。
備考欄もあるので、例えば、「その単語が使われるタイミングについて」など、その単語にまつわることをデータに残しておけます。
ログイン機能を有しており、ユーザーは自身が登録した単語は編集、削除ができ、全てのユーザーは検索、お気に入り機能を利用することができます。

# 本番環境
https://word-storage-31168.herokuapp.com/

ログイン情報（テスト用）

* Name: test
* Password: test123

# 制作背景（意図）
プログラミング学習を通して必ず避けては通れない「英語を読む・書く」ということ。
分からない単語が出る度にそれを調べ、知識として蓄えますが、時間が経つと忘れてしまうものもあると思います。
私自身もそれを調べる作業に時間をかけてきた1人です。
その調べた結果がちょっとでも形として残るように、また、同じような境遇の人と英語を通して情報を共有できるように、備忘録として使用してもらうためにこのアプリケーションを制作しました。

# DEMO

### トップページ（登録単語一覧画面）
未ログイン
[![Image from Gyazo](https://i.gyazo.com/d9c3f4e6fe815136373c43c9130c9880.jpg)](https://gyazo.com/d9c3f4e6fe815136373c43c9130c9880)

ログイン済み
[![Image from Gyazo](https://i.gyazo.com/2d3ebdb8a9e234d0b26adc250f7a7f8f.jpg)](https://gyazo.com/2d3ebdb8a9e234d0b26adc250f7a7f8f)

* このアプリに登録されている全ての英単語が一覧表示されます。
* ログインの有無は問いません。
* ヘッダーにはタイトルと、ログインしていない場合はログインとサインアップのボタンが、ログインしている場合はユーザー名と単語の登録するためのボタンが表示されます。
* ユーザー名にカーソルを合わせるとマイページとログアウトボタンが表示されます。
* 検索フォームから登録してある単語を検索することが出来ます。

### ワード詳細ページ
[![Image from Gyazo](https://i.gyazo.com/55c855deff81c3a1342ae2263ac468b2.jpg)](https://gyazo.com/55c855deff81c3a1342ae2263ac468b2)

* 登録してある英単語の意味（日本語訳）と備考（その単語にまつわる情報）が表示されます。
* ログインの有無は問いません。
* その単語を登録したユーザーであれば、編集、削除ボタンが表示されます。
* ログインしていればどのユーザーにも、お気に入りに追加、もしくは、すでにお気に入りに追加した単語であればお気に入り解除ボタンが表示されます。

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
| remarks  | text       |                                |
| user     | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :favorites
- has_many :fav_users, through: :favorites, source: user

## favoritesテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| word    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :word