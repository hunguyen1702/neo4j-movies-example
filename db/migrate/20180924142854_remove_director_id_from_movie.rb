class RemoveDirectorIdFromMovie < ActiveRecord::Migration
  def change
    remove_column :movies, :director_id
  end
end
