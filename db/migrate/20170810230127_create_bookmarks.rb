class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :webpage_id

      t.timestamp :last_seen_at

      t.timestamps
    end
  end
end
