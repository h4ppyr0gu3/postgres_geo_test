# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

HEADERS = %w[
geonameid
name
asciiname
alternatenames
latitude
longitude
'feature class'
'feature code'
'country code'
cc2
'admin1 code'
'admin2 code'
'admin3 code'
'admin4 code'
'population'
'elevation'
dem
timezone          
'modification date'
].freeze

CSV.foreach(Rails.root.join('test_data.txt'), col_sep: "\t", quote_char: "\"") do |csv|

  Point.find_or_create_by!(name: csv[1], region: csv[2], latitude: csv[4], longitude: csv[5])
end
