
require 'json'
require 'open-uri'
require 'csv'
require 'date'
require 'nokogiri'

puts "Destruction de la database"

Law.destroy_all
Representative.destroy_all
District.destroy_all
#Création district

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
      district_coordinates: district["geometry"].inspect
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
      first_name: representative["depute"]["prenom"],
      last_name: representative["depute"]["nom_de_famille"],
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
      id_an: id_pa ,
      slug: representative["depute"]["slug"] 
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


# PROPOSITIONS DE LOIS
url_prop = 'https://www2.assemblee-nationale.fr/documents/liste/(type)/propositions-loi'
html_file = open(url_prop).read
doc = Nokogiri::HTML(html_file)
  
doc.search('.liens-liste > li').first(30).each do |law|
  puts "creating proposition..."
  months = {
    janvier: 1,
    février: 2,
    mars: 3,
    avril: 4,
    mai: 5,
    juin: 6,
    juillet: 7,
    aout: 8,
    septembre: 9,
    octobre: 10,
    novembre: 11,
    décembre: 12
  }
  title = law.search('h3').text
  num = title.match(/(N°.)(\d+)/)[2] if title.match(/(N°.)(\d+)/)
  description = law.search('p').text
  details = law.search('.liens-liste-embed a').attribute('href').value
  p site_date = law.search('.liens-liste-embed li .heure').text.split(" ") 
  p creation_date = Date.parse("#{site_date[6]}/#{months[site_date[5].to_sym]}/#{site_date[4]}") if site_date != []

  html_file = open(details).read
  doc = Nokogiri::HTML(html_file)
  
  doc.search('.carrousel-auteurs-rapporteurs').each do |law|
    auteur_link = law.search('.nom-personne a').attribute('href').value
    auteur_id = auteur_link.match(/PA\d+/)[0] if auteur_link.match(/PA\d+/)
    auteur_name = law.search('.nom-personne a').text
    
    if creation_date != nil
      law = Law.new(
        num: num,
        title: title, 
        description: description,
        url: details,
        source: "Proposition",
        author_type: "auteur",
        author: auteur_name,
        id_an: auteur_id,
        date: creation_date
        # representative_id: Representative.where(id_an: law.id_an)
      )
      puts "created proposition!"
      law.save!
    end
  end
end


# PROJETS DE LOIS
url_proj = 'https://www2.assemblee-nationale.fr/documents/liste/(type)/projets-loi'
html_file = open(url_proj).read
doc = Nokogiri::HTML(html_file)

doc.search('.liens-liste > li').first(30).each do |law|
  puts "creating projet..."
  months = {
    janvier: 1,
    février: 2,
    mars: 3,
    avril: 4,
    mai: 5,
    juin: 6,
    juillet: 7,
    aout: 8,
    septembre: 9,
    octobre: 10,
    novembre: 11,
    décembre: 12
  }
  title = law.search('h3').text
  num = title.match(/(N°.)(\d+)/)[2] if title.match(/(N°.)(\d+)/)
  description = law.search('p').text
  details = law.search('a').attribute('href').value
  p site_date = law.search('.liens-liste-embed li .heure').text.split(" ")
  p creation_date = Date.parse("#{site_date[6]}/#{months[site_date[5].to_sym]}/#{site_date[4]}") if site_date != []
  

  html_file = open(details).read
  doc = Nokogiri::HTML(html_file)
  
  doc.search('.carrousel-auteurs-rapporteurs').each do |law|
    rapporteur_link = law.search('.nom-personne a').attribute('href').value
    rapporteur_id = rapporteur_link.match(/PA\d+/)[2] if rapporteur_link.match(/PA\d+/)
    rapporteur_name = law.search('.nom-personne a').text

    if creation_date != nil
      law = Law.new(
        num: num,
        title: title, 
        description: description,
        url: details,
        source: "Projet",
        author_type: "rapporteur",
        author: rapporteur_name,
        id_an: rapporteur_id,
        date: creation_date
        # representative_id: Representative.where(id_an: law.id_an)
      )
      puts "created proposition!"
      law.save!
    end
  end
end

