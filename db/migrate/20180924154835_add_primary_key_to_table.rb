class AddPrimaryKeyToTable < ActiveRecord::Migration
  def change
    add_column :people_person_types, :id, :primary_key
    add_column :movies_people, :id, :primary_key
  end
end
