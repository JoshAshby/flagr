class CreateScrapes < ActiveRecord::Migration[5.1]
  def change
    create_table :scrapes do |t|
      t.references :webpage, foreign_key: true, null: false

      t.string :title
      t.string :language
      t.text :links, array: true, default: []
      t.text :body
      t.text :content
      t.text :cleaned

      t.timestamps
    end
  end
end
