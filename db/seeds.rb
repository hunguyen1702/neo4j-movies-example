require 'csv'

def read_file_content file_names
  csv_path = "db/csv_files"
  file = File.join csv_path, file_names
  content = File.read file
  CSV.parse content, headers: true
end

def get_datetime_from_timestamp str
  Time.at(str.to_f / 1000).to_datetime
end

def get_list_objects csv
  csv.map do |row|
    JSON.parse row.to_hash.values.first
  end
end

def person_mapping data
  person = data.deep_symbolize_keys
  person_params = {}
  person_params[:id] = person[:id]
  person_params[:birthday] = get_datetime_from_timestamp person[:properties][:birthday]
  person_params[:birthplace] = person[:properties][:birthplace]
  person_params[:name] = person[:properties][:name]
  person_params[:biography] = person[:properties][:biography]
  person_params[:profile_img] = person[:properties][:profileImageUrl]
  [Person.new(person_params), person]
end

def load_and_create_person file_names
  csv = read_file_content file_names
  list_objects = get_list_objects csv
  people = []
  list_objects.each do |object|
    person = person_mapping object
    person, object = person_mapping object
    person_type_names = object[:labels].map &:downcase
    person_type_names.delete "person"
    person_type_names.each do |name|
      person_type = PersonType.find_or_create_by name: name
      person.person_types << person_type
    end
    people << person
  end
  Person.import people
end
["actors.csv", "directors.csv"].each {|file| load_and_create_person file}

import_users = []
user_csv = read_file_content "users.csv"
users = get_list_objects user_csv
users.each do |user|
  user_params = {
    id: user["id"],
    username: user["properties"]["login"],
    name: user["properties"]["name"],
    password: "123123",
    password_confirmation: "123123",
    email: "#{user["properties"]["login"]}@gmail.com"
  }
  user = User.new user_params
  import_users << user
end
User.import import_users

movie_csv = read_file_content "movies.csv"
movies = get_list_objects movie_csv
import_movies = []
movies.each do |movie|
  movie_params = {
    id: movie["id"],
    studio: movie["properties"]["studio"],
    release_date: get_datetime_from_timestamp(movie["properties"]["releaseDate"]),
    imdb_id: movie["properties"]["imdbId"],
    runtime: movie["properties"]["runtime"],
    description: movie["properties"]["description"],
    language: movie["properties"]["language"],
    title: movie["properties"]["title"],
    trailer: movie["properties"]["trailer"],
    image_url: movie["properties"]["imageUrl"],
    genre: movie["properties"]["genre"],
    tag_line: movie["properties"]["tagline"],
    homepage: movie["properties"]["homepage"]
  }
  movie = Movie.new movie_params
  import_movies << movie
end
Movie.import import_movies

directed_csv = read_file_content "directed.csv"
directed = get_list_objects directed_csv
directed.each do |directed_movie|
  person = Person.find directed_movie["start"]
  movie = Movie.find directed_movie["end"]
  movie.director = person
  movie.save
end

import_acts = []
act_csv = read_file_content "acts_in.csv"
acts = get_list_objects act_csv
acts.each do |act|
  person = Person.find act["start"]
  movie = Movie.find act["end"]
  act_in_movie = ActInMovie.new actor_id: person.id, movie_id: movie.id
  import_acts << act_in_movie
end
ActInMovie.import import_acts

rated_csv = read_file_content "rated.csv"
rates = get_list_objects rated_csv
rates.each do |rate|
  user = User.find rate["start"]
  movie = Movie.find rate["end"]
  rate = Rate.new user_id: user.id, movie_id: movie.id,
    comment: rate["properties"]["conmment"], star: rate["properties"]["star"]
  rate.save
end

friend_csv = read_file_content "friends.csv"
friends = get_list_objects friend_csv
friends.each do |friend|
  user = User.find friend["start"]
  user1 = User.find friend["end"]
  friendship = FriendShip.new user_id: user.id, friend_user_id: user1.id
  friendship.save
end
