class Neo4j::Actor < Neo4j::Person
  include Neo4j::ActiveNode
  include Neo4j::UndeclaredProperties

  self.mapped_label_name = "Actor"
end
