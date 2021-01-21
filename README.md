# WordStorage
<font size=3>〜プログラミング学習単語帳アプリ〜<font>

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
記述するコード、エラーメッセージ、参考として読む文献、これら全てに英語が使用されている為、プログラミングの理解を深めるためには英語の知識は自ずと必要になってきます。  
私自身も多くの時間を英語に対して費やしてきました。  
その中で感じたのは、単語の意味をある程度理解した上で学習した方が効率が良いということです。  
そこで今回、単語を意識して登録することによって、知識として定着させることができればと考えました。  
少しでも学習の効率アップに繋がればと思い、また、同じような境遇の人と英語を通して情報を共有できるように、英語専門の備忘録としてこのアプリケーションを制作しました。

# DEMO

### トップページ（登録単語一覧画面）
**〈未ログイン時〉**
[![Image from Gyazo](https://i.gyazo.com/a22e68a31fa168ccf3e216abf34fd6e1.jpg)](https://gyazo.com/a22e68a31fa168ccf3e216abf34fd6e1)

**〈ログイン済み〉**
[![Image from Gyazo](https://i.gyazo.com/6bd24389f86eff576375ad6e90e5e860.jpg)](https://gyazo.com/6bd24389f86eff576375ad6e90e5e860)

* このアプリに登録されている全ての英単語が一覧表示されます。
* ログインの有無は問いません。
* 表示されている英単語をクリックするとその単語の詳細ページに遷移します。
* ヘッダーにはタイトルと、ログインしていない場合はログインとサインアップのボタンが、ログインしている場合はユーザー名と単語の登録するためのボタンが表示されます。
* ユーザー名にカーソルを合わせるとマイページとログアウトボタンが表示されます。
* 検索フォームから登録してある単語を検索することが出来ます。

### ワード登録ページ
[![Image from Gyazo](https://i.gyazo.com/31585036b08d6b041569c77a696bd4fa.jpg)](https://gyazo.com/31585036b08d6b041569c77a696bd4fa)

**〈単語登録GIF〉**
[![Image from Gyazo](https://i.gyazo.com/6f7d8e4de2f031f1efc3fc3391fd27ec.gif)](https://gyazo.com/6f7d8e4de2f031f1efc3fc3391fd27ec)

* 英語、日本語、備考欄があります。
* 英語、日本語欄が空だと登録できません。
* 英語欄には半角アルファベットのみ入力することができます。
* モデル及びデータベースレベルで保存に問題がなければ、Registerボタンを押すことで単語を登録することができ、トップページに遷移します。
* 登録ができなかった場合、登録ページに戻されます。



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