class CreateJoinTablePersonPersonType < ActiveRecord::Migration
  def change
    create_join_table :people, :person_types do |t|
      t.index [:person_id, :person_type_id], unique: true
    end
  end
end
