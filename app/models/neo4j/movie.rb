class Neo4j::Movie
  include Neo4j::ActiveNode
  include Neo4j::UndeclaredProperties

  self.mapped_label_name = "Movie"
  has_many :in, :directors, type: :DIRECTED, model_class: Neo4j::Director.name
  has_many :in, :actors, type: :ACTS_IN, model_class: Neo4j::Actor.name
  has_many :in, :rated_users, type: :RATED, model_class: Neo4j::User.name
end
