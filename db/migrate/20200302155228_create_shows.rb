class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :artist
      t.string :title
      t.text :description
      t.string :genre
      t.references :venue, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :original_image
      t.string :thumb_image
      t.integer :price
      t.string :age_category
      t.string :warnings
      t.string :website
      t.boolean :active
      t.datetime :updated
      t.string :twitter

      t.timestamps
    end
  end
end
