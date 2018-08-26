class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :studio
      t.datetime :release_date
      t.string :imdb_id
      t.integer :runtime
      t.text :description
      t.string :language
      t.string :title
      t.string :trailer
      t.string :image_url
      t.string :genre
      t.text :tag_line
      t.string :homepage

      t.timestamps null: false
    end
  end
end
