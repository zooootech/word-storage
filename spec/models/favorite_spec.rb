require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  describe "お気に入り登録機能" do
    context "お気に入り登録がうまくいくとき" do
      it "userとwordが紐付いていれば登録できる" do
        expect(@favorite).to be_valid
      end
    end
    context "お気に入り登録がうまくいかないとき" do
      it "userが紐付いていないと登録できない" do
        @favorite.user = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("User must exist")
      end
      it "wordが紐付いていないと登録できない" do
        @favorite.word = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("Word must exist")
      end
    end
  end
end
