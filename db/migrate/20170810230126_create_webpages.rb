class CreateWebpages < ActiveRecord::Migration[5.1]
  def change
    create_table :webpages do |t|
      t.string :uri

      t.timestamps
    end
  end
end
