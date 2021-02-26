require 'json'

module ScrappingRepresentativeConcern
  def scrapping
    url = "https://www.nosdeputes.fr/#{@representative.slug}/json"
    info_deputes_serialized = open(url).read
    info_deputes = JSON.parse(info_deputes_serialized)

    url = "https://www.nosdeputes.fr/synthese/data/json"
    activite_deputes_serialized = open(url).read
    actitive_deputes = JSON.parse(info_deputes_serialized)

    #  activite_deputes[0]["depute"]["nb_mandats"]
    #  activite_deputes[0]["semaines_presence"]
    #  [activite_deputes[0]"comission_presences"]
    #  activite_deputes[0]["comission_interventions"]
    #  activite_deputes[0]["hemicycle_interventions"]
    #  activite_deputes[0]["hemicycle_interventions_courtes"]
    #  activite_deputes[0]["amendements_proposes"]
    #  activite_deputes[0]["amendements_signes"]
    #  activite_deputes[0]["amendements_signes"]
    #  activite_deputes[0]["rapports"]
    #  activite_deputes[0]["propositions_ecrites"]
    #  activite_deputes[0]["propositions_signees"]
    #  activite_deputes[0]["questions_ecrites"]
    #  activite_deputes[0]["questions_orales"]
  end
end