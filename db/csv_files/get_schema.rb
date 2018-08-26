require 'csv'
require 'json'

Dir.chdir "/home/hunguyen/projects/neo4j-movie"
file_ext = ".csv"
list_of_db_files = Dir.glob "*#{file_ext}"


def get_longest_properties file_path
  csv_content = File.read file_path
  csv = CSV.parse csv_content, headers: true
  list_objects = csv.map do |row|
    JSON.parse row.to_hash.values.first
  end
  list_objects.map{|object| object["properties"]}
    .map(&:keys).max_by &:length
end

def properties_from_data_files list_files, file_ext
  list_files.map do |file_name|
    properties = get_longest_properties file_name
    [File.basename(file_name, file_ext), properties]
  end
end

properties_from_data_files list_of_db_files, file_ext
