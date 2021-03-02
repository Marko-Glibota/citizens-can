require 'json'
require 'open-uri'
require 'rgeo/geo_json'
require 'geokit'

class RepresentativesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  include Pagy::Backend
  include ScrappingRepresentativeConcern

  def index
    
    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
      @representatives = @representatives.where(sql_query, query: "%#{params[:query]}%")
    else 
      @representatives = Representative.all
    end

    @pagy, @representatives = pagy(@representatives, items: 30)

    @representatives_lrem = @representatives.where(party_acronym: "LREM")
    @representatives_mdda = @representatives.where(party_acronym: "MODEM")
    @representatives_ae = @representatives.where(party_acronym: "AE")
    @representatives_lr = @representatives.where(party_acronym: "LR")
    @representatives_soc = @representatives.where(party_acronym: "SOC")
    @representatives_udi = @representatives.where(party_acronym: "UDI")
    @representatives_lt = @representatives.where(party_acronym: "LT")
    @representatives_lfi = @representatives.where(party_acronym: "LFI")
    @representatives_gdr = @representatives.where(party_acronym: "GDR")
    @representatives_ni = @representatives.where(party_acronym: "NI")
  end
  
  def show
    @representative = Representative.find(params[:id])
    @name = "#{@representative.first_name} #{@representative.last_name}"
    @years_old = Date.today.year - @representative.birth_date.year
    @laws = Law.all
    scrapping
  end

  def search
    #Recuperer l'input du user
    @address = params[:query]
    #Transformer l'adresse en coordonées
    results = Geocoder.search(@address)
    #Stocker ces coordonées
    @user_coordinates = results.first.coordinates
    #Récuperer tout les polygones et itérer dessus.
    @districts = District.all
    @districts.each do |district|
      district_coordinates = eval(district.district_coordinates)
      next if district_coordinates.empty?

      polygon_coordinates = district_coordinates["coordinates"].flatten(1)
      # raise if polygon_coordinates.first.first.is_a? Array
      # if polygon_coordinates.first.first.is_a? Array
      #   polygon_coordinates = polygon_coordinates.flatten(1)
      # end
      p polygon_coordinates
      while polygon_coordinates[0][0].is_a?(Array)
        polygon_coordinates = polygon_coordinates.flatten(1)
      end
  
      points = []
      polygon_coordinates.each do |coordinate|      
        points << Geokit::LatLng.new(coordinate[1], coordinate[0])
      end
      polygon = Geokit::Polygon.new(points)
      if polygon.contains?(Geokit::LatLng.new(@user_coordinates[0], @user_coordinates[1]))
        return redirect_to representative_path(district.representative)
      end
    end
    redirect_to root_path
  end
end

#Recuperer l'input du user
    #Iterer sur tout les polygones.
    #If user's addrress coordinates are inside the district's, then user's district_id = district
    #----------------------------------------------------------------------------------------------
    #