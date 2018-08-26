class User < ActiveRecord::Base
  has_many :rates, dependent: :destroy
  has_many :movie_rates, through: :rates, class_name: Movie.name
  has_many :friend_ships, dependent: :destroy
  has_many :friends, through: :friend_ships, class_name: User.name
end
