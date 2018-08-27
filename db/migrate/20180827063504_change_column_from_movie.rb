class ChangeColumnFromMovie < ActiveRecord::Migration
  def change
    change_column :movies, :trailer, :text
    change_column :movies, :image_url, :text
    change_column :movies, :homepage, :text
  end
end
