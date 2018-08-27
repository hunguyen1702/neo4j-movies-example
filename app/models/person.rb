class Person < ActiveRecord::Base
  has_many :act_in_movies, dependent: :destroy
  has_many :acted_movies, through: :act_in_movies, class_name: Movie.name
  has_many :directed_movies, class_name: Movie.name, dependent: :destroy,
    foreign_key: :director_id
  has_and_belongs_to_many :person_types
end
