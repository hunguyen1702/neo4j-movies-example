class CreateActInMovies < ActiveRecord::Migration
  def change
    create_table :act_in_movies do |t|
      t.integer :actor_id, index: true, references: [:users, :id]
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
