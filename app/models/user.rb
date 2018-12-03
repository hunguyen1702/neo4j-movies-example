class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :rates, dependent: :destroy
  has_many :movie_rates, through: :rates, class_name: Movie.name
  has_many :friend_ships, dependent: :destroy
  has_many :friends, through: :friend_ships, class_name: User.name,
    source: :friend_user
end
