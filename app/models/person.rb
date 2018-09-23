class Person < ActiveRecord::Base
  has_many :act_in_movies, dependent: :destroy, foreign_key: :actor_id
  has_many :acted_movies, through: :act_in_movies, class_name: Movie.name,
    source: :movie
  has_many :directed_movies, class_name: Movie.name, dependent: :destroy,
    foreign_key: :director_id
  has_many :people_person_types, dependent: :destroy
  has_many :person_types, through: :people_person_types, source: :person_type
end
