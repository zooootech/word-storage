class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :english,  null: false
      t.string :japanese, null: false
      t.text   :remarks
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
