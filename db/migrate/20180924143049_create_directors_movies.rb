class CreateDirectorsMovies < ActiveRecord::Migration
  def change
    create_join_table :people, :movies do |t|
      t.index [:person_id, :movie_id], unique: true
    end
  end
end
