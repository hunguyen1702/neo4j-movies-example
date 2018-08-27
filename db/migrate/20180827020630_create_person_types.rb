class CreatePersonTypes < ActiveRecord::Migration
  def change
    create_table :person_types do |t|
      t.string :name

      t.timestamps null: false
    end

    add_index :person_types, :name, unique: true
  end
end
