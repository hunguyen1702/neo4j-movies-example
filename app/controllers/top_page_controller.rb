class TopPageController < ApplicationController
  def index
    load_recommended_movies_by_neo4j
  end

  private

  def load_recommended_movies_by_sql
    user = User.find_by_email("adilfulara@gmail.com")
  end

  def load_recommended_movies_by_neo4j
    query = <<-QUERY
      match (u:User {login: 'adilfulara'})-[r:RATED]->(movie:Movie)<-[:ACTS_IN]-(actor:Actor)
      where r.stars >= 3
      with u, r, movie, actor
      match (actor)-[:ACTS_IN]->(m:Movie)
      with u, actor, count(1) as acted, movie
      where acted >= 10
      with u, actor, acted, movie
      match (actor)-[:ACTS_IN]->(m1:Movie)<-[:ACTS_IN]-(coActor:Actor),
        (coActor)-[:ACTS_IN]->(m2:Movie)<-[:ACTS_IN]-(cocoActor:Actor)
      where not (actor)-[:ACTS_IN]->()<-[:ACTS_IN]-(cocoActor)
      with cocoActor, actor
      match (cocoActor)-[:ACTS_IN]->(movie:Movie)
      where not (actor)-[:ACTS_IN]->(movie)
      return movie limit 5
    QUERY
    ids = Neo4j::ActiveBase.current_session.query(query)
      .rows.map(&:first).map(&:id)
    @movies = Movie.where id: ids
  end
end
