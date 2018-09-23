class Neo4j::Person
  include Neo4j::ActiveNode
  include Neo4j::UndeclaredProperties

  self.mapped_label_name = "Person"
  has_many :out, :movie, type: :ACTS_IN, model_class: Neo4j::Movie.name
end
