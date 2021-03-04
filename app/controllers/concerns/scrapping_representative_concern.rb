require 'json'

module ScrappingRepresentativeConcern
  def scrapping
    #Info perso député
    url = "https://www.nosdeputes.fr/#{@representative.slug}/json"
    info_perso_deputes_serialized = open(url).read
    info_perso_deputes = JSON.parse(info_perso_deputes_serialized)
    info_perso_depute = info_perso_deputes["depute"]

    # Autres misisons
    @infos_perso_depute = info_perso_depute["responsabilites"]
    # info_perso_depute["responsabilites"].each do |responsabilite|
    #   @organisme_reponsabilite = responsabilite["responsabilite"]["organisme"]
    #   @fonction_reponsabilite = responsabilite["responsabilite"]["fonction"]
    #   @debut_de_fonction_reponsabilite = responsabilite["responsabilite"]["debut_fonction"]
    # end

    # Missions extra-parlementaires
    info_perso_depute["responsabilites_extra_parlementaires"].each do |responsabilites_extra_parlementaires|
      @organisme_reponsabilite_extra_parlementaire = responsabilites_extra_parlementaires["organisme"]
      @fonction_reponsabilite_extra_parlementaire = responsabilites_extra_parlementaires["fonction"]
      @debut_de_fonction_reponsabilite_extra_parlementaire = responsabilites_extra_parlementaires["debut_fonction"]
    end

    # Contact internet
    info_perso_depute["sites_web"].each do |site_web|
      @depute_site_web = site_web
    end

    info_perso_depute["emails"].each do |email|
      @depute_email = email
    end

  # Activités Députés
    url = "https://www.nosdeputes.fr/synthese/data/json"
    activites_deputes_serialized = open(url).read
    activites_deputes = JSON.parse(activites_deputes_serialized)
    @activites_array = activites_deputes["deputes"]

    @activites_array.each do |depute|
      if depute["depute"]["id_an"] == @representative.id_an.split("PA").last
        @depute_nb_mandats = depute["depute"]["nb_mandats"]
        @depute_semaines_presence = depute["depute"]["semaines_presence"]
        @depute_comission_presences = depute["depute"]["commission_presences"]
        @depute_comission_interventions = depute["depute"]["commission_interventions"]
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
