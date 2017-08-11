class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true, null: false
      t.references :webpage, foreign_key: true, null: false

      t.timestamp :last_seen_at

      t.timestamps
    end
  end
end
