require 'uri'
require 'net/http'

api_key = "69c13a9b5d6b958e136df927e8d681b5"
api = "https://api.themoviedb.org/3/find/"
query_string = "?external_source=imdb_id&language=en-US&api_key="
img_prefix_url = "http://image.tmdb.org/t/p/w500"
ids_file = "/home/hunguyen/projects/neo4j-movie/neo4j-movie/db/csv_files/list_movie_ids.txt"
list_ids = []
File.open(ids_file).each_line {|line| list_ids << line.strip}

responses = []
thread_pool = []
pool_size = 30

list_ids.each do |id|
  url = URI("#{api}#{id}#{query_string}#{api_key}")
  thr = Thread.new do
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request.body = "{}"

    begin
      response = http.request(request)
      puts "[#{response.code} #{response.message}] #{id} #{response.read_body.truncate(100)}"
      img_path = JSON.parse(response.read_body).deep_symbolize_keys[:movie_results].first[:poster_path]
      puts "\t\t #{img_path}"
      [id, "#{img_prefix_url}#{img_path}"]
    rescue
      nil
    end
  end
  thread_pool << thr
  responses << thr
  if thread_pool.length >= pool_size
    sleep 10
    thread_pool.each(&:join)
    thread_pool = []
  end
end

thread_pool.each(&:join)
responses.map!(&:value).compact!


output_file = "/home/hunguyen/projects/neo4j-movie/neo4j-movie/db/csv_files/list_imgs.json"
img_list_file = File.open(output_file, "w")
JSON.dump(responses.to_h, img_list_file)


output_file = "/home/hunguyen/projects/neo4j-movie/neo4j-movie/db/csv_files/list_imgs.json"
file = File.open output_file
list_id_with_img = JSON.parse(file.read).keys
output_file = "/home/hunguyen/projects/neo4j-movie/neo4j-movie/db/csv_files/list_imgs_1.json"
file = File.open output_file
list_id_with_img += JSON.parse(file.read).keys
ids_file = "/home/hunguyen/projects/neo4j-movie/neo4j-movie/db/csv_files/list_movie_ids.txt"
list_ids = []
File.open(ids_file).each_line {|line| list_ids << line.strip}
list_id_without_img = list_ids - list_id_with_img
responses = []
thread_pool = []
pool_size = 15
list_id_without_img.each do |id|
  url = URI("#{api}#{id}#{query_string}#{api_key}")
  thr = Thread.new do
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request.body = "{}"

    begin
      response = http.request(request)
      puts "[#{response.code} #{response.message}] #{id} #{response.read_body.truncate(100)}"
      img_path = JSON.parse(response.read_body).deep_symbolize_keys[:tv_results]
      puts "\t\t #{img_path}"
      [id, "#{img_prefix_url}#{img_path}"]
    rescue
      nil
    end
  end
  thread_pool << thr
  responses << thr
  if thread_pool.length >= pool_size
    sleep 10
    thread_pool.each(&:join)
    thread_pool = []
  end
end

thread_pool.each(&:join)
