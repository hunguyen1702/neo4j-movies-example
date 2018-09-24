class Movie < ActiveRecord::Base
  has_many :rates, dependent: :destroy
  has_many :user_rates, through: :rates, class_name: User.name
  has_many :act_in_movies, dependent: :destroy
  has_many :actors, through: :act_in_movies, class_name: Person.name
  has_many :movies_people, dependent: :destroy, class_name: MoviesPerson.name,
   foreign_key: :movie_id
  has_many :directors, through: :movies_people, class_name: Person.name,
    source: :person, foreign_key: :movie_id
end
