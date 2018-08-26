class ActInMovie < ActiveRecord::Base
  belongs_to :actor, class_name: Person.name, foreign_key: :actor_id
  belongs_to :movie
end
