class Neo4j::Director < Neo4j::Person
  include Neo4j::ActiveNode
  include Neo4j::UndeclaredProperties

  self.mapped_label_name = "Director"
  has_many :out, :movie, type: :DIRECTED, model_class: Neo4j::Movie.name
end
