 require 'json'

module ScrappingRepresentativeConcern
  def scrapping
    url = "https://www.nosdeputes.fr/#{@representative.slug}/json"
    info_perso_deputes_serialized = open(url).read
    info_perso_deputes = JSON.parse(info_perso_deputes_serialized)

    url = "https://www.nosdeputes.fr/synthese/data/json"
    activites_deputes_serialized = open(url).read
    activites_deputes = JSON.parse(activites_deputes_serialized)
    activites_array = activites_deputes["deputes"]

    activites_array.each do |depute|
      if depute["depute"]["id_an"] = @representative.id_an
        @depute_nb_mandats = depute["depute"]["nb_mandats"]
        @depute_semaines_presence = depute["depute"]["semaines_presence"]
        @depute_comission_presences = depute["depute"]["comission_presences"]
        @depute_comission_interventions = depute["depute"]["comission_interventions"]
        @depute_interventions_hemicycle = depute["depute"]["hemicycle_interventions"]
        @depute_interventions_courtes = depute["depute"]["hemicycle_interventions_courtes"]
        @depute_amendements_proposes = depute["depute"]["amendements_proposes"]
        @depute_amendements_signes = depute["depute"]["amendements_signes"]
        @depute_rapports = depute["depute"]["rapports"]
        @depute_propositions_ecrites = depute["depute"]["propositions_ecrites"]
        @depute_propositions_signees = depute["depute"]["propositions_signees"]
        @depute_questions_ecrites = depute["depute"]["questions_ecrites"]
        @depute_question_orales = depute["depute"]["questions_orales"]
      end
    end
  end
end
