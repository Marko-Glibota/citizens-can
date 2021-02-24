# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or newd alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.new([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.new(name: 'Luke', movie: movies.first)

# Mettrer les news dans une variable pour pouvoir ajouter les ids
#Destroy_all


#Créer une nouvelle instance district

require 'json'
require 'open-uri'
require 'csv'

# url = "https://static.data.gouv.fr/resources/carte-des-circonscriptions-legislatives-2012-et-2017/20170721-135742/france-circonscriptions-legislatives-2012.json"
# districts_serialized = open(url).read
# districts = JSON.parse(districts_serialized)

# # puts districts["features"].first["geometry"]["coordinates"]

# districts.each do |district|
#   district = District.new(
#     department_code: district["features"].first["properties"]["code_dpt"],
#     department_name: districts["features"].first["properties"]["nom_dpt"],
#     district_num: districts["features"].first["properties"]["num_circ"],
#     district_coordinates: districts["features"].first["geometry"]["coordinates"]
#   )
#   district.save!
# end

# Creer une nouvelle instance de loi

require 'open-uri'
require 'nokogiri'


# PROPOSITIONS DE LOIS
url_prop = 'https://www2.assemblee-nationale.fr/documents/liste/(type)/propositions-loi'
html_file = open(url_prop).read
doc = Nokogiri::HTML(html_file)

doc.search('.liens-liste li').each do |law|
  title = law.search('h3').text
  description = law.search('p').text
  details << law.search('a').attribute('href')

  # html_file = open(details).read
  # doc = Nokogiri::HTML(html_file)
  
  # doc.search('.liens-liste li').each do |law|
  # binding.pry

  law = Law.new(
    title: title,
    description: description,
    url: details,
    source: "proposition")

  law.save
end


# PROJETS DE LOIS
url_proj = 'https://www2.assemblee-nationale.fr/documents/liste/(type)/projets-loi'
html_file = open(url_proj).read
doc = Nokogiri::HTML(html_file)

doc.search('.liens-liste li').each do |law|
  title = law.search('h3').text
  description = law.search('p').text
  details = law.search('a').attribute('href')

  law = Law.new(
    title: title,
    description: description,
    url: details,
    source: "projet")

  law.save
end
