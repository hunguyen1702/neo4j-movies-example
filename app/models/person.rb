class Person < ActiveRecord::Base
  has_many :act_in_movies, dependent: :destroy, foreign_key: :actor_id
  has_many :acted_movies, through: :act_in_movies, class_name: Movie.name,
    source: :movie
  has_many :people_person_types, dependent: :destroy
  has_many :person_types, through: :people_person_types, source: :person_type
  has_many :movies_people, dependent: :destroy, class_name: MoviesPerson.name,
    foreign_key: :person_id
  has_many :directed_movies, through: :movies_people, class_name: Movie.name,
    source: :movie, foreign_key: :person_id
end
