require 'rails_helper'

RSpec.describe "お気に入りに追加", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @word = FactoryBot.create(:word)
  end
  it "ログインしたユーザーはワードをお気に入りに追加することができる" do
    # ログインする
    visit new_user_session_path
    fill_in "Name", with: @user.name
    fill_in "Password", with: @user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # トップページに登録されているワードの英語が表示されていることを確認する
    expect(page).to have_link @word.english, href: "/words/#{@word.id}"
    # ワードの英語をクリックするとワードの詳細ページに遷移することを確認する
    find_link(@word.english, href: "/words/#{@word.id}").click
    expect(current_path).to eq(word_path(@word))
    # ワードの詳細ページにお気に入りに追加するボタンがあることを確認する
    expect(page).to have_link "お気に入りに追加", href: "/words/#{@word.id}/favorites"
    # 「お気に入りに追加」ボタンをクリックするとマイページに遷移することを確認する
    find_link("お気に入りに追加", href: "/words/#{@word.id}/favorites").click
    expect(current_path).to eq(user_path(@user))
    # マイページにお気に入りに追加したワードの英語が表示されていることを確認する
    expect(page).to have_link @word.english, href: "/words/#{@word.id}"
    # お気に入りに追加したワードの英語をクリックするとワードの詳細ページに遷移することを確認する
    find_link(@word.english, href: "/words/#{@word.id}").click
    expect(current_path).to eq(word_path(@word))
    # ワードの詳細ページに、お気に入りに追加するボタンがなく、お気に入りを解除するボタンがあることを確認する
    expect(page).to have_no_link "お気に入りに追加", href: "/words/#{@word.id}/favorites"
    expect(page).to have_link "お気に入り解除", href: "/words/#{@word.id}/favorites/#{Favorite.all[0][:word_id]}"
  end
  it "ログインしていないユーザーはワードをお気に入りに追加することができない" do
    # トップページに移動する
    visit root_path
    # トップページにワードの英語が表示されていることを確認する
    expect(page).to have_link @word.english, href: "/words/#{@word.id}"
    # ワードの英語をクリックするとワードの詳細ページに遷移することを確認する
    find_link(@word.english, href: "/words/#{@word.id}").click
    expect(current_path).to eq(word_path(@word))
    # ワードの詳細ページにお気に入りに追加するボタンがないことを確認する
    expect(page).to have_no_link "お気に入りに追加", href: "/words/#{@word.id}/favorites"
  end
end

RSpec.describe "お気に入り解除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @word = FactoryBot.create(:word)
    @favorite = Favorite.create(user_id: @user.id, word_id: @word.id)
  end
  it "ログインしたユーザーはワードのお気に入りを解除することができる" do
    # お気に入りに追加したワードがあるユーザーでログインする
    visit new_user_session_path
    fill_in "Name", with: @user.name
    fill_in "Password", with: @user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # トップページに、お気に入りに追加しているワードの英語が表示されていることを確認する
    expect(page).to have_link @word.english, href: "/words/#{@word.id}"
    # ワードの英語をクリックするとワードの詳細ページに遷移することを確認する
    find_link(@word.english, href: "/words/#{@word.id}").click
    expect(current_path).to eq(word_path(@word))
    # ワードの詳細ページにお気に入りを解除するボタンがあることを確認する
    expect(page).to have_link "お気に入り解除", href: "/words/#{@word.id}/favorites/#{Favorite.all[0][:word_id]}"
    # 「お気に入り解除」ボタンをクリックするとマイページに遷移することを確認する
    find_link("お気に入り解除", href: "/words/#{@word.id}/favorites/#{Favorite.all[0][:word_id]}").click
    expect(current_path).to eq(user_path(@user))
    # トップページに移動する
    visit root_path
    # トップページに表示されている、お気に入りを解除したワードの英語をクリックして、ワードの詳細ページに遷移する
    expect(page).to have_link @word.english, href: "/words/#{@word.id}"
    find_link(@word.english, href: "/words/#{@word.id}").click
    expect(current_path).to eq(word_path(@word))
    # ワードの詳細ページに、お気に入りを解除するボタンがなく、お気に入りに追加するボタンがあることを確認する
    expect(page).to have_no_link "お気に入りを解除", href: "/words/#{@word.id}/favorites/#{@word.id}}"
    expect(page).to have_link "お気に入りに追加", href: "/words/#{@word.id}/favorites"
  end
  it "ログインしていないユーザーはワードのお気に入りを解除することができない" do
    # トップページに移動する
    visit root_path
    # トップページにワードの英語が表示されていることを確認する
    expect(page).to have_link @word.english, href: "/words/#{@word.id}"
    # ワードの英語をクリックするとワードの詳細ページに遷移することを確認する
    find_link(@word.english, href: "/words/#{@word.id}").click
    expect(current_path).to eq(word_path(@word))
    # ワードの詳細ページにお気に入りに追加するボタンがないことを確認する
    expect(page).to have_no_link "お気に入り解除", href: "/words/#{@word.id}/favorites/#{Favorite.all[0][:word_id]}"
  end
end
