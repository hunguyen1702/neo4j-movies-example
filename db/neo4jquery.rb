update_img_link = <<-CYPHER
  call apoc.load.json('file:///home/hunguyen/setups/neo4j-community-3.4.6/bin/list_imgs.json') yield value
  with [k in keys(value) | value[k]] as imgUrl, keys(value) as imdbId
  with extract(i in range(0, size(imdbId) - 1) | {id: imdbId[i], url: imgUrl[i]}) as result
  unwind result as row
  match (m:Movie {imdbId: row.id})
  set m.imageUrl = row.url
CYPHER

colab_filter_query = <<-CYPHER
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
CYPHER
