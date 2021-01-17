require 'rails_helper'

RSpec.describe "Words", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @word = FactoryBot.create(:word)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq(200)
    end
    it "indexアクションにリクエストするとレスポンスに登録済みのワードの英語が存在する" do
      get root_path
      expect(response.body).to include(@word.english)
    end
    it "indexアクションにリクエストするとレスポンスに検索フォームが存在する" do
      get root_path
      expect(response.body).to include("検索")
    end
  end

  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
      sign_in(@user)
      get word_path(@word)
      expect(response.status).to eq(200)
    end
    it "showアクションにリクエストするとレスポンスに登録済みのワードの英語が存在する" do
      sign_in(@user)
      get word_path(@word)
      expect(response.body).to include(@word.english)
    end
    it "showアクションにリクエストするとレスポンスに登録済みにワードの日本語が存在する" do
      sign_in(@user)
      get word_path(@word)
      expect(response.body).to include(@word.japanese)
    end
    it "showアクションにリクエストするとレスポンスに登録済みのワードの備考が存在する" do
      sign_in(@user)
      get word_path(@word)
      expect(response.body).to include(@word.remarks)
    end
    it "showアクションにリクエストするとレスポンスに検索フォームが存在する" do
      sign_in(@user)
      get word_path(@word)
      expect(response.body).to include("検索")
    end
  end
end
