
require 'json'
require 'open-uri'
require 'csv'
require 'date'
require 'nokogiri'

puts "Destruction de la database"

Comment.destroy_all
Law.destroy_all
Representative.destroy_all
District.destroy_all
User.destroy_all
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
  site_date = law.search('.liens-liste-embed li .heure').text.split(" ") 
  creation_date = Date.parse("#{site_date[6]}/#{months[site_date[5].to_sym]}/#{site_date[4]}") if site_date != []

  html_file = open(details).read
  doc = Nokogiri::HTML(html_file)
  
  doc.search('.carrousel-auteurs-rapporteurs').each do |law|
    auteur_link = law.search('.nom-personne a').attribute('href').value
    auteur_id = auteur_link.match(/PA\d+/)[0] if auteur_link.match(/PA\d+/)
    auteur_name = law.search('.nom-personne a').text
    
    if creation_date != nil
      img_array = []
      img_array << "https://www.actu-environnement.com/images/illustrations/breve/35166_large.jpg"
      img_array << "https://media-exp1.licdn.com/dms/image/C4E1BAQGhVbo2nGUTVg/company-background_10000/0/1549039117898?e=2159024400&v=beta&t=tazZDKI3DRVKY_LGXDDWr5ASCL5CwbACjDw6mfispUo"
      img_array << "https://img.20mn.fr/yJRDt54zRViCXAYNXb0J6w/814x360_assemblee-nationale-illustration.jpg"
      img_array << "https://cdn-lejdd.lanmedia.fr/var/europe1/storage/images/lejdd/politique/assemblee-nationale-7-choses-a-savoir-sur-le-fauteuil-de-president-3749012/50000393-1-fre-FR/Assemblee-nationale-7-choses-a-savoir-sur-le-fauteuil-de-president.jpg"
      img_array << "https://www2.assemblee-nationale.fr/var/ezflow_site/storage/images/media/patrimoine/palais-bourbon/bibliotheque-le-plafond/6690-4-fre-FR/bibliotheque-le-plafond.jpg"
      img_array << "https://www.touteleurope.eu/fileadmin/_TLEv3/emploi_social/AN_dumping.jpg"
      img_array << "https://www2.assemblee-nationale.fr/var/ezflow_site/storage/images/media/travail-parlementaire/une-seance-dans-l-hemicycle-de-l-assemblee-nationale/345237-1-fre-FR/une-seance-dans-l-hemicycle-de-l-assemblee-nationale.jpg"
      img_array << "https://img-4.linternaute.com/kvSFNKKfTHLjrKZR0BXuRKdJNhQ=/1240x/smart/7e9ea50adfe4458b82c1a31859552184/ccmcms-linternaute/10578833.jpg"
      img_array << "https://reporterre.net/local/cache-vignettes/L720xH480/arton22295-dec87.jpg?1613409946"
      img_array << "https://www.letudiant.fr/static/uploads/mediatheque/EDU_EDU/3/3/2351133-rea-263949-032-580x310.jpg"
      img_array << "https://img.aws.la-croix.com/2017/06/27/1200858482/LAssemblee-nationale-26-2017_0_729_486.jpg"
      img_array << "https://club21siecle.org/wp-content/uploads/2020/09/assembl%C3%A9e-nationale.png"

      law_creation = Law.new(
        num: num,
        title: title, 
        description: description,
        url: details,
        source: "Proposition",
        author_type: "auteur",
        author: auteur_name,
        id_an: auteur_id,
        date: creation_date,
        photo: img_array.sample,
        # representative_id: Representative.where(id_an: law_creation.id_an)
      )
      law_creation.save!
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
  site_date = law.search('.liens-liste-embed li .heure').text.split(" ")
  creation_date = Date.parse("#{site_date[6]}/#{months[site_date[5].to_sym]}/#{site_date[4]}") if site_date != []
  

  html_file = open(details).read
  doc = Nokogiri::HTML(html_file)
  
  doc.search('.carrousel-auteurs-rapporteurs').each do |law|
    rapporteur_link = law.search('.nom-personne a').attribute('href').value
    rapporteur_id = rapporteur_link.match(/PA\d+/)[2] if rapporteur_link.match(/PA\d+/)
    rapporteur_name = law.search('.nom-personne a').text

    if creation_date != nil
      img_array = []
      img_array << "https://www.actu-environnement.com/images/illustrations/breve/35166_large.jpg"
      img_array << "https://media-exp1.licdn.com/dms/image/C4E1BAQGhVbo2nGUTVg/company-background_10000/0/1549039117898?e=2159024400&v=beta&t=tazZDKI3DRVKY_LGXDDWr5ASCL5CwbACjDw6mfispUo"
      img_array << "https://img.20mn.fr/yJRDt54zRViCXAYNXb0J6w/814x360_assemblee-nationale-illustration.jpg"
      img_array << "https://cdn-lejdd.lanmedia.fr/var/europe1/storage/images/lejdd/politique/assemblee-nationale-7-choses-a-savoir-sur-le-fauteuil-de-president-3749012/50000393-1-fre-FR/Assemblee-nationale-7-choses-a-savoir-sur-le-fauteuil-de-president.jpg"
      img_array << "https://www2.assemblee-nationale.fr/var/ezflow_site/storage/images/media/patrimoine/palais-bourbon/bibliotheque-le-plafond/6690-4-fre-FR/bibliotheque-le-plafond.jpg"
      img_array << "https://www.touteleurope.eu/fileadmin/_TLEv3/emploi_social/AN_dumping.jpg"
      img_array << "https://www2.assemblee-nationale.fr/var/ezflow_site/storage/images/media/travail-parlementaire/une-seance-dans-l-hemicycle-de-l-assemblee-nationale/345237-1-fre-FR/une-seance-dans-l-hemicycle-de-l-assemblee-nationale.jpg"
      img_array << "https://img-4.linternaute.com/kvSFNKKfTHLjrKZR0BXuRKdJNhQ=/1240x/smart/7e9ea50adfe4458b82c1a31859552184/ccmcms-linternaute/10578833.jpg"
      img_array << "https://reporterre.net/local/cache-vignettes/L720xH480/arton22295-dec87.jpg?1613409946"
      img_array << "https://www.letudiant.fr/static/uploads/mediatheque/EDU_EDU/3/3/2351133-rea-263949-032-580x310.jpg"
      img_array << "https://img.aws.la-croix.com/2017/06/27/1200858482/LAssemblee-nationale-26-2017_0_729_486.jpg"
      img_array << "https://club21siecle.org/wp-content/uploads/2020/09/assembl%C3%A9e-nationale.png"

      @representatives = Representative.all
      law_creation = Law.new(
        num: num,
        title: title, 
        description: description,
        url: details,
        source: "Projet",
        author_type: "rapporteur",
        author: rapporteur_name,
        id_an: rapporteur_id,
        date: creation_date,
        photo: img_array.sample,
        # representative_id: Representatives.where(id_an == law_creation.id_an)
        )
      law_creation.save!
    end
  end
end

