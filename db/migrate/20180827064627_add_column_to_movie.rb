class AddColumnToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :director_id, :integer, index: true,
      references: [:person, :id]
  end
end
