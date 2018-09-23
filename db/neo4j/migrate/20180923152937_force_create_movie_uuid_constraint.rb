class ForceCreateMovieUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Movie, :uuid, force: true
  end

  def down
    drop_constraint :Movie, :uuid
  end
end
