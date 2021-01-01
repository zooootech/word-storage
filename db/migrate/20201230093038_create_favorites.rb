class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.timestamps

      t.index [:user_id, :word_id], unique: true # DBレベルで一意性をチェック
    end
  end
end
