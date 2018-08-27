require 'wombat'

base_url = "https://www.imdb.com"

def return_poster_link data, key
  data[key].match(/ src="(.+)">/)[1]
end

Dir.chdir "/home/hunguyen/projects/neo4j-movie/neo4j-movie/db"
list_ids = []
File.open("csv_files/list_movie_ids.txt").each_line {|line| list_ids << line.strip}
list_ids.reject! &:empty?

list_imgs = list_ids.map do |id|
  img_tag = Wombat.crawl do
    base_url base_url
    path "/title/#{id}/"
    img_tag "css=div.poster", :html
  end
  [id, return_poster_link(img_tag, "img_tag")]
end

File.open("csv_files/list_imgs.txt", "w") do |f|
  f.puts list_imgs
end
