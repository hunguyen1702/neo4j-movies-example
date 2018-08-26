class Person < ActiveRecord::Base
  enum type: [:actor, :director]
  has_many :act_in_movies, dependent: :destroy
  has_many :acted_movies, through: :act_in_movies, class_name: Movie.name
  has_many :directed_movies, class_name: Movie.name, dependent: :destroy
end
