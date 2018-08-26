class CreateActInMovies < ActiveRecord::Migration
  def change
    create_table :act_in_movies do |t|
      t.references :actor, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
