class Movie < ActiveRecord::Base
  has_many :rates, dependent: :destroy
  has_many :user_rates, through: :rates, class_name: User.name
  has_many :act_in_movies, dependent: :destroy
  has_many :actors, through: :act_in_movies, class_name: Person.name
  belongs_to :director, class_name: Person.name, foreign_key: :director_id
end
