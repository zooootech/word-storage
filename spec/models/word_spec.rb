require 'rails_helper'

RSpec.describe Word, type: :model do
  before do
    @word = FactoryBot.build(:word)
  end

  describe "ワード登録機能" do
    context "ワード登録がうまくいくとき" do
      it "englishとjapaneseが存在すれば登録できる" do
        @word.remarks = ""
        expect(@word).to be_valid
      end
      it "englishが半角アルファベットであれば登録できる" do
        @word.english = "orange"
        expect(@word).to be_valid
      end
    end
    context "ワード登録がうまくいかないとき" do
      it "englishが空だと登録できない" do
        @word.english = ""
        @word.valid?
        expect(@word.errors.full_messages).to include("English can't be blank")
      end
      it "japaneseが空だと登録できない" do
        @word.japanese = ""
        @word.valid?
        expect(@word.errors.full_messages).to include("Japanese can't be blank")
      end
      it "englishが半角アルファベット以外だと登録できない" do
        @word.english = "アップル"
        @word.valid?
        expect(@word.errors.full_messages).to include("English には半角アルファベットのみ使用してください")
      end
      it "userが紐付いていないと登録できない" do 
        @word.user = nil
        @word.valid?
        expect(@word.errors.full_messages).to include("User must exist")
      end
    end
  end
end
