class RemoveIndexFromPeople < ActiveRecord::Migration
  def change
    remove_index :people, name: "index_people_on_name"
  end
end
