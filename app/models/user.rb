class User < ActiveRecord::Base
  has_many :rates, dependent: :destroy
  has_many :movie_rates, through: :rates, class_name: Movie.name
end
