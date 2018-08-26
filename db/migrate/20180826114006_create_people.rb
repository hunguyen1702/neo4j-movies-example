class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.datetime :birthday
      t.string :birthplace
      t.string :name
      t.text :biography
      t.string :profile_img
      t.references :type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
