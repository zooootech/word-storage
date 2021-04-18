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
* 表示されている単語をクリックするとその単語の詳細ページに遷移します。
* ヘッダーにはタイトルと、ログインしていない場合はログインとサインアップのボタンが、ログインしている場合はユーザー名と単語の登録するためのボタンが表示されます。
* ユーザー名にカーソルを合わせるとマイページとログアウトボタンが表示されます。
* ログインの有無に関わらず、ユーザーは検索フォームから登録してある単語を検索することが出来ます。

### サインアップページ
[![Image from Gyazo](https://i.gyazo.com/6549b5fe1a805343268ec948d6a23693.jpg)](https://gyazo.com/6549b5fe1a805343268ec948d6a23693)

* NameとPassword、PasswordConfirmationの入力欄があります。
* サインアップするには全ての項目を入力しなければなりません。
* 一意性制約により、既に登録されているNameは使用できません。
* 登録が完了すると、トップページに遷移します。
* 登録ができなかった場合、サインアップページに戻されます。

### ログインページ
[![Image from Gyazo](https://i.gyazo.com/2a4f9fc27fe8fbe805339ca2402c85fe.jpg)](https://gyazo.com/2a4f9fc27fe8fbe805339ca2402c85fe)

* NameとPasswordの入力欄があります。
* 登録されていないNameやPasswordを入力してもログインできません。
* ログインが完了すると、トップページに遷移します。
* ログインができなかった場合、ログインページに戻されます。

### ワード登録ページ
[![Image from Gyazo](https://i.gyazo.com/31585036b08d6b041569c77a696bd4fa.jpg)](https://gyazo.com/31585036b08d6b041569c77a696bd4fa)

**〈ワード登録GIF〉**
[![Image from Gyazo](https://i.gyazo.com/6f7d8e4de2f031f1efc3fc3391fd27ec.gif)](https://gyazo.com/6f7d8e4de2f031f1efc3fc3391fd27ec)

* ログインしているユーザーのみ単語の登録ができます。
* 英語、日本語、備考欄があります。
* 英語、日本語欄が空だと登録できません。
* 英語欄には半角アルファベット、_(アンダースコア)、.(ドット)、,(カンマ)、半角スペースのみ入力することができます。
* モデル及びデータベースレベルで保存に問題がなければ、Registerボタンを押すことで単語を登録することができ、トップページに遷移します。
* 登録ができなかった場合、登録ページに戻されます。

### ワード詳細ページ
[![Image from Gyazo](https://i.gyazo.com/55b9e3aa39fbc33b6c12c6229314de84.jpg)](https://gyazo.com/55b9e3aa39fbc33b6c12c6229314de84)

* 登録してある単語の意味（日本語訳）と備考（その単語にまつわる情報）が表示されます。
* ログインの有無は問いません。
* その単語を登録したユーザーであれば、編集、削除ボタンが表示されます。
* ログインしていればどのユーザーにも、お気に入りに追加、もしくは、すでにお気に入りに追加した単語であればお気に入り解除ボタンが表示されます。

### ワード編集ページ
[![Image from Gyazo](https://i.gyazo.com/9a9814aa2459334830661e14fd78a173.jpg)](https://gyazo.com/9a9814aa2459334830661e14fd78a173)

* ログインしているユーザーのみ、自身が登録した単語の編集ができます。
* 仕様は単語の登録と同じです。
* 編集が完了すると、詳細ページに遷移します。
* 編集ができなかった場合、編集ページに戻されます。

### マイページ
[![Image from Gyazo](https://i.gyazo.com/fb256d8bc18761ddc6cfbaf01508fcc9.jpg)](https://gyazo.com/fb256d8bc18761ddc6cfbaf01508fcc9)

* ログインしているユーザーのみマイページに遷移することができます。
* マイページには、自身が登録した単語と、お気に入りに追加している単語が一覧表示されます。
* 表示されている単語をクリックするとその単語の詳細ページに遷移します。

### 〈検索機能GIF〉
[![Image from Gyazo](https://i.gyazo.com/a7c5a2a3820d09ae3b883798d66b2da0.gif)](https://gyazo.com/a7c5a2a3820d09ae3b883798d66b2da0)

* 検索をすると、検索フォームに入力された文字を含むデータが一覧表示されます。
* ログインの有無は問いません。
* 一覧表示されている項目のどれかをクリックすると、その項目が含まれている単語の詳細ページに遷移します。

# 工夫したポイント

* deviseの認証を、emailからnameに変更。（emailだと長い為、文字制限のないnameを使用し、デフォルトより簡易な認証機能に変更。）
* 意識して覚えたい単語を判別するためにお気に入り機能を設定。
* 英単語の一覧がアルファベット順で表示されるように設定。
* ログイン失敗時にもエラーメッセージが表示されるように設定。
* 気になる単語を調べられるように検索機能を実装。

# 学びとなったポイント

* deviseの認証機能をemailからnameに変更するには、各ビューファイルのemailの部分をnameに変更、deviseのメソッドのオーバーライド、deviseの設定ファイル(/config/initializers/devise.rb)の編集などを行う必要がある。
* お気に入りテーブルを作成する際、user_idとword_idの重複を防ぐために、DBレベルではカラムにuniqueインデックス作成し、モデルレベルではバリデーションとして、uniquenessヘルパーとscopeオプションを用いて一意性制約を設定。DBとモデル両方に一意性を保つことでより安全性が高まる。
* 検索機能やお気に入り単語を並べ替えるといった、データとやりとりをするメソッド（ビジネスロジック）はコントローラーではなくモデルに置く。
* deviseのデフォルトでは、サインアップ時のみエラーメッセージが表示される仕様になっている為、ログイン時のエラーメッセージについては、deviseのflashオブジェクトに格納されているflashメッセージを表示させる必要がある。
* 検索機能などのビジネスロジック（データに対する処理などを行うプログラム処理）は、コントローラーではなく、モデルに置いた方が好ましい。その際、クラスメソッドとしての扱いとなるため、メソッド名の前に「self」を付けることや、引数を利用しコントローラーから呼び出すことを意識する。
* RspecのRequest Specで、deviseのsign_inメソッドを使用するためには、spec/rails_helper.rbに以下を記述。

  ```
  RSpec.configure do |config|
  # 省略
    config.include Devise::Test::IntegrationHelpers, type: :request
  end
  ```
* その他、以下Qiitaの記事にまとめました。  
  
  お気に入り機能とルーティングのネストについて  
  https://qiita.com/zooootech/items/53734327d757450d7fca  
  
  中間テーブルのアソシエーション  
  https://qiita.com/zooootech/items/544e0d69a1184d293350  
  
  Railsでtext_areaに入力した文章を改行込で表示させる方法  
  https://qiita.com/zooootech/items/d0b05713e1bef490325f  

# 使用技術（開発環境）
## バックエンド
Ruby, Ruby on Rails  

## フロントエンド
HTML, CSS  

## データベース
MySQL, Sequel Pro  

## ソース管理
GitHub, GitHubDesktop  

## テスト
RSpec  

## エディタ
VSCode  

# DB設計
## usersテーブル

| Column             | Type   | Options                        |
| ------------------ | ------ | ------------------------------ |
| name               | string | null: false                    |
| encrypted_password | string | null: false                    |

### Association
- has_many :words
- has_many :favorites
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