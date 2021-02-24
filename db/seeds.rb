# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or newd alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.new([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.new(name: 'Luke', movie: movies.first)


require 'json'
require 'open-uri'
require 'date'


puts "Destruction de la database"
Representative.destroy_all
District.destroy_all
  

url = "https://static.data.gouv.fr/resources/carte-des-circonscriptions-legislatives-2012-et-2017/20170721-135742/france-circonscriptions-legislatives-2012.json"
districts_serialized = open(url).read
districts = JSON.parse(districts_serialized)

(1..12).each do |district_num|
  District.create!(
    department_code: 977,
    department_name: "Francais etablis hors de France",
    district_num: district_num,
    district_coordinates: []
  )
end
 

districts["features"].each do |district|
  district = District.new(
    department_code: district["properties"]["code_dpt"],
    department_name: district["properties"]["nom_dpt"],
    district_num: district["properties"]["num_circ"],
    district_coordinates: district["geometry"]["coordinates"].flatten
  )
  puts "Création d'une circonscription"
  district.save!
end



url = "https://www.nosdeputes.fr/deputes/enmandat/json"
representatives_serialized = open(url).read
representatives = JSON.parse(representatives_serialized)

representatives["deputes"].each do |representative|
  id_pa = "PA#{representative["depute"]["id_an"]}"
  representative_instance = Representative.new(
    first_name: representative["depute"]["nom_de_famille"],
    last_name: representative["depute"]["prenom"],
    gender: representative["depute"]["sexe"],
    addresses: representative["depute"]["adresses"].flat_map(&:values),
    department_name: representative["depute"]["nom_circo"],
    collaborators: representative["depute"]["collaborateurs"].flat_map(&:values) ,
    party_acronym: representative["depute"]["groupe_sigle"] ,
    seat_number: representative["depute"]["place_en_hemicycle"],
    district_num: representative["depute"]["num_circo"],
    department_code: representative["depute"]["num_deptmt"],
    start_mandate: representative["depute"]["mandat_debut"],
    birth_date: representative["depute"]["date_naissance"],
    profession: representative["depute"]["profession"],
    url_an: representative["depute"]["url_an"],
    id_an: id_pa  
  )

  if representative["depute"]["emails"] == []
    email = "webmestre@assemblee-nationale.fr"
  else
    email = representative["depute"]["emails"][0]["email"]
  end
  representative_instance.email = email

  if representative["depute"]["collaborateurs"] == []
    collaborators = ["none"]
  else
    collaborators = representative["depute"]["collaborateurs"].flat_map(&:values)
  end
  representative_instance.collaborators = collaborators

  department_name = representative_instance[:department_name].mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  department_name = "la reunion" if department_name == "reunion"
  department_name = "polynesie-francaise" if department_name == "polynesie francaise"
  department_name = "saint-martin\/saint-barthelemy" if department_name == "saint-barthelemy et saint-martin"
      
  representative_instance.district = District.where(district_num: representative_instance[:district_num]).where("lower(department_name) = ? ", department_name ).first
  puts "Création d'un député"
  representative_instance.save!
      
end




