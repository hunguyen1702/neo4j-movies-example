class Neo4j::User < Neo4j::Person
  include Neo4j::ActiveNode
  include Neo4j::UndeclaredProperties

  self.mapped_label_name = "User"
  has_many :out, :rated_movies, type: :RATED, model_class: Neo4j::Movie.name
  has_many :out, :friends, type: :FRIEND, model_class: self.name
end
