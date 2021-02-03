require 'rails_helper'

RSpec.describe 'ワード登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @word_english = 'apple'
    @word_japanese = 'りんご'
    @word_remarks = '果物'
  end
  context 'ワード登録ができるとき' do
    it 'ログインしたユーザーは正しい情報を入力すれば登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Name', with: @user.name
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにワード登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_link '登録する', href: '/words/new'
      # 「登録する」ボタンを押すとワード登録画面へ遷移することを確認する
      find_link('登録する', href: '/words/new').click
      expect(current_path).to eq(new_word_path)
      # ワード情報を入力する
      fill_in 'word_english', with: @word_english
      fill_in 'word_japanese', with: @word_japanese
      fill_in 'word_remarks', with: @word_remarks
      # 登録ボタンを押すとWordモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Word.count }.by(1)
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページに登録したワードの英語が存在することを確認する
      expect(page).to have_link @word_english, href: "/words/#{Word.all[0][:id]}"
    end
  end
  context 'ワード登録ができないとき' do
    it 'ログインしていないとワード登録ページに遷移できない' do
      # トップページに移動する
      visit root_path
      # トップページにワード登録ページに遷移するボタンがないことを確認する
      expect(page).to have_no_link '登録する', href: '/words/new'
    end
    it 'ログインしたユーザーでも誤った情報を入力すると登録できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Name', with: @user.name
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにワード登録画面へ遷移するボタンがあることを確認する
      expect(page).to have_link '登録する', href: '/words/new'
      # 「登録する」ボタンを押すとワード登録画面へ遷移することを確認する
      find_link('登録する', href: '/words/new').click
      expect(current_path).to eq(new_word_path)
      # 誤った情報を入力する
      fill_in 'word_english', with: 'みかん'
      fill_in 'word_japanese', with: ''
      fill_in 'word_remarks', with: ''
      # 登録ボタンを押してもWordモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Word.count }.by(0)
      # ワード登録ページに戻されることを確認する
      expect(current_path).to eq('/words')
    end
  end
end

RSpec.describe 'ワード編集' do
  before do
    @word1 = FactoryBot.create(:word)
    @word2 = FactoryBot.create(:word)
  end
  context 'ワード編集ができるとき' do
    it 'ログインしたユーザーは自分が登録したワードの編集ができる' do
      # ワード1を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Name', with: @word1.user.name
      fill_in 'Password', with: @word1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにワード1の英語が表示されていることを確認する
      expect(page).to have_link @word1.english, href: "/words/#{@word1.id}"
      # ワード1の英語をクリックするとワード1の詳細ページに遷移することを確認する
      find_link(@word1.english, href: "/words/#{@word1.id}").click
      expect(current_path).to eq(word_path(@word1))
      # ワード1の詳細ページに編集ページに遷移するボタンがあることを確認する
      expect(page).to have_link '編集', href: "/words/#{@word1.id}/edit"
      # 「編集」ボタンをクリックすると編集ページに遷移することを確認する
      find_link('編集', href: "/words/#{@word1.id}/edit").click
      expect(current_path).to eq(edit_word_path(@word1))
      # すでに登録済みの内容がフォームに入っていることを確認する
      expect(
        find('#word_english').value
      ).to eq(@word1.english)
      # 登録内容を編集する
      fill_in 'word_english', with: "#{@word1.english}orange"
      fill_in 'word_japanese', with: "#{@word1.japanese} + みかん"
      fill_in 'word_remarks', with: "#{@word1.remarks} + 果物2"
      # 登録ボタンを押してもWordモデルのカウントが変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Word.count }.by(0)
      # ワード1の詳細ページに遷移することを確認する
      expect(current_path).to eq(word_path(@word1))
      # ワード1の詳細ページにて、編集した内容が反映されていることを確認する
      expect(page).to have_content("#{@word1.english}orange")
      expect(page).to have_content("#{@word1.japanese} + みかん")
      expect(page).to have_content("#{@word1.remarks} + 果物2")
    end
  end
  context 'ワード編集ができないとき' do
    it 'ログインしていないとワード編集ページに遷移できない' do
      # トップページに移動する
      visit root_path
      # トップページにワード1の英語が表示されていることを確認する
      expect(page).to have_link @word1.english, href: "/words/#{@word1.id}"
      # ワード1の英語をクリックするとワード1の詳細ページに遷移することを確認する
      find_link(@word1.english, href: "/words/#{@word1.id}").click
      expect(current_path).to eq(word_path(@word1))
      # ワード1の詳細ページに編集ページに遷移するボタンがないことを確認する
      expect(page).to have_no_link '編集', href: "/words/#{@word1.id}/edit"
    end
    it 'ログインしたユーザーは自分以外が登録したワードの編集ページに遷移できない' do
      # ワード1を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Name', with: @word1.user.name
      fill_in 'Password', with: @word1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにワード2の英語が表示されていることを確認する
      expect(page).to have_link @word2.english, href: "/words/#{@word2.id}"
      # ワード2の英語をクリックするとワード2の詳細ページに遷移することを確認する
      find_link(@word2.english, href: "/words/#{@word2.id}").click
      expect(current_path).to eq(word_path(@word2))
      # ワード2の詳細ページに編集ページに遷移するボタンがないことを確認する
      expect(page).to have_no_link '編集', href: "/words/#{@word2.id}/edit"
    end
    it 'ログインしたユーザーでも誤った情報を入力すると編集できない' do
      # ワード1を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Name', with: @word1.user.name
      fill_in 'Password', with: @word1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにワード1の英語が表示されていることを確認する
      expect(page).to have_link @word1.english, href: "/words/#{@word1.id}"
      # ワード1の英語をクリックするとワード1の詳細ページに遷移することを確認する
      find_link(@word1.english, href: "/words/#{@word1.id}").click
      expect(current_path).to eq(word_path(@word1))
      # ワード1の詳細ページに編集ページに遷移するボタンがあることを確認する
      expect(page).to have_link '編集', href: "/words/#{@word1.id}/edit"
      # 「編集」ボタンをクリックすると編集ページに遷移することを確認する
      find_link('編集', href: "/words/#{@word1.id}/edit").click
      expect(current_path).to eq(edit_word_path(@word1))
      # すでに登録済みの内容がフォームに入っていることを確認する
      expect(
        find('#word_english').value
      ).to eq(@word1.english)
      # 登録内容を編集する
      fill_in 'word_english', with: "#{@word1.english}りんご"
      fill_in 'word_japanese', with: "#{@word1.japanese} + みかん"
      fill_in 'word_remarks', with: "#{@word1.remarks} + 果物2"
      # 登録ボタンを押してもWordモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Word.count }.by(0)
      # ワード編集ページに戻されることを確認する
      expect(current_path).to eq("/words/#{@word1.id}")
    end
  end
end

RSpec.describe 'ワード削除' do
  before do
    @word1 = FactoryBot.create(:word)
    @word2 = FactoryBot.create(:word)
  end
  context 'ワード削除ができるとき' do
    it 'ログインしたユーザーは自分が登録したワードの削除ができる' do
      # ワード1を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Name', with: @word1.user.name
      fill_in 'Password', with: @word1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにワード1の英語が表示されていることを確認する
      expect(page).to have_link @word1.english, href: "/words/#{@word1.id}"
      # ワード1の英語をクリックするとワード1の詳細ページに遷移することを確認する
      find_link(@word1.english, href: "/words/#{@word1.id}").click
      expect(current_path).to eq(word_path(@word1))
      # ワード1の詳細ページに削除を行うボタンがあることを確認する
      expect(page).to have_link '削除', href: "/words/#{@word1.id}"
      # 「削除」ボタンを押すとWordモデルのカウントが1減ることを確認する
      expect do
        find_link('削除', href: "/words/#{@word1.id}").click
      end.to change { Word.count }.by(-1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページにワード1の英語が表示されていないことを確認する
      expect(page).to have_no_link @word1.english, href: "/words/#{@word1.id}"
    end
  end
  context 'ワード削除ができないとき' do
    it 'ログインしていないとワードの削除ができない' do
      # トップページに移動する
      visit root_path
      # トップページにワード1の英語が表示されていることを確認する
      expect(page).to have_link @word1.english, href: "/words/#{@word1.id}"
      # ワード1の英語をクリックするとワード1の詳細ページに遷移することを確認する
      find_link(@word1.english, href: "/words/#{@word1.id}").click
      expect(current_path).to eq(word_path(@word1))
      # ワード1の詳細ページに削除を行うボタンがないことを確認する
      expect(page).to have_no_link '削除', href: "/words/#{@word1.id}"
    end
    it 'ログインしたユーザーは自分以外が登録したワードの削除ができない' do
      # ワード1を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Name', with: @word1.user.name
      fill_in 'Password', with: @word1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにワード2の英語が表示されていることを確認する
      expect(page).to have_link @word2.english, href: "/words/#{@word2.id}"
      # ワード2の英語をクリックするとワード2の詳細ページに遷移することを確認する
      find_link(@word2.english, href: "/words/#{@word2.id}").click
      expect(current_path).to eq(word_path(@word2))
      # ワード2の詳細ページに削除を行うボタンがないことを確認する
      expect(page).to have_no_link '削除', href: "/words/#{@word2.id}"
    end
  end
end

RSpec.describe 'ワード詳細' do
  before do
    @word1 = FactoryBot.create(:word)
    @word2 = FactoryBot.create(:word)
  end
  it 'ログインしたユーザーは、自分が登録したワードの詳細ページに「編集」ボタンと「削除」ボタンが表示される' do
    # ワード1を登録したユーザーでログインする
    visit new_user_session_path
    fill_in 'Name', with: @word1.user.name
    fill_in 'Password', with: @word1.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # トップページにワード1の英語が表示されていることを確認する
    expect(page).to have_link @word1.english, href: "/words/#{@word1.id}"
    # ワード1の英語をクリックするとワード1の詳細ページに遷移することを確認する
    find_link(@word1.english, href: "/words/#{@word1.id}").click
    expect(current_path).to eq(word_path(@word1))
    # ワード1の詳細ページに編集ページに遷移するボタンと削除を行うボタンがあることを確認する
    expect(page).to have_link '編集', href: "/words/#{@word1.id}/edit"
    expect(page).to have_link '削除', href: "/words/#{@word1.id}"
  end
  it 'ログインしたユーザーは、自分以外が登録したワードの詳細ページ遷移できるものの、「編集」ボタンと「削除」ボタンが表示されない' do
    # ワード1を登録したユーザーでログインする
    visit new_user_session_path
    fill_in 'Name', with: @word1.user.name
    fill_in 'Password', with: @word1.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # トップページにワード2の英語が表示されていることを確認する
    expect(page).to have_link @word2.english, href: "/words/#{@word2.id}"
    # ワード2の英語をクリックするとワード2の詳細ページに遷移することを確認する
    find_link(@word2.english, href: "/words/#{@word2.id}").click
    expect(current_path).to eq(word_path(@word2))
    # ワード2の詳細ページに編集ページに遷移するボタンと削除を行うボタンがないことを確認する
    expect(page).to have_no_link '編集', href: "/words/#{@word2.id}/edit"
    expect(page).to have_no_link '削除', href: "/words/#{@word2.id}"
  end
end
