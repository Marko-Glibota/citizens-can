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

url = "https://static.data.gouv.fr/resources/carte-des-circonscriptions-legislatives-2012-et-2017/20170721-135742/france-circonscriptions-legislatives-2012.json"
districts_serialized = open(url).read
districts = JSON.parse(districts_serialized)

puts districts["features"].first["geometry"]["coordinates"]
