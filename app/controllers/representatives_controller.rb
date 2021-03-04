require 'json'
require 'open-uri'
require 'rgeo/geo_json'
require 'geokit'

class RepresentativesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  include Pagy::Backend
  include ScrappingRepresentativeConcern

  def index
    @representatives = Representative.all

    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
      @representatives = @representatives.where(sql_query, query: "%#{params[:query]}%")
    else
      @representatives = Representative.all
    end
    
    @representatives_count = @representatives.count
    
    @representatives_lrem = @representatives.where(party_acronym: "LREM")
    @representatives_lrem_count = @representatives_lrem.count
    @pagy_lrem, @representatives_lrem = pagy(@representatives_lrem, items: 42)

    @representatives_mdda = @representatives.where(party_acronym: "MODEM")
    @representatives_mdda_count = @representatives_mdda.count
    @pagy_mdda, @representatives_mdda = pagy(@representatives_mdda, items: 42)

    @representatives_ae = @representatives.where(party_acronym: "AE")
    @representatives_ae_count = @representatives_ae.count
    @pagy_ae, @representatives_ae = pagy(@representatives_ae, items: 6)

    @representatives_lr = @representatives.where(party_acronym: "LR")
    @representatives_lr_count = @representatives_lr.count
    @pagy_lr, @representatives_lr = pagy(@representatives_lr, items: 6)

    @representatives_soc = @representatives.where(party_acronym: "SOC")
    @representatives_soc_count = @representatives_soc.count
    @pagy_soc, @representatives_soc = pagy(@representatives_soc, items: 6)

    @representatives_udi = @representatives.where(party_acronym: "UDI")
    @representatives_udi_count = @representatives_udi.count
    @pagy_udi, @representatives_udi = pagy(@representatives_udi, items: 6)

    @representatives_lt = @representatives.where(party_acronym: "LT")
    @representatives_lt_count = @representatives_lt.count
    @pagy_lt, @representatives_lt = pagy(@representatives_lt, items: 6)

    @representatives_lfi = @representatives.where(party_acronym: "LFI")
    @representatives_lfi_count = @representatives_lfi.count
    @pagy_lfi, @representatives_lfi = pagy(@representatives_lfi, items: 6)

    @representatives_gdr = @representatives.where(party_acronym: "GDR")
    @representatives_gdr_count = @representatives_gdr.count
    @pagy_gdr, @representatives_gdr = pagy(@representatives_gdr, items: 6)

    @representatives_ni = @representatives.where(party_acronym: "NI")
    @representatives_ni_count = @representatives_ni.count
    @pagy_ni, @representatives_ni = pagy(@representatives_ni, items: 6)
    
    @pagy, @representatives = pagy(@representatives, items: 42)
  end
  
  def show
    @representative = Representative.find(params[:id])
    @name = "#{@representative.first_name} #{@representative.last_name}"
    @years_old = Date.today.year - @representative.birth_date.year
    @laws = Law.all
    @user = current_user
    scrapping
  end

  def user_request
    @representative = Representative.find(params[:id])
    @user = current_user
    @message = params[:m]
    @objet = params[:o]
    UserMailer.with(user: @user, message: @message, objet: @objet, representative: @representative).request
    redirect_to representative_path(@representative), :flash => { :notice => "Message envoyé !" }
  end

  def search
    @address = params[:query]

    district = ReturnDistrictFromAddress.new(@address).call

    if district
      redirect_to representative_path(district.representative)
    else
      redirect_to root_path
    end
  end
end

    # #Recuperer l'input du user
    # @address = params[:query]
    # #Transformer l'adresse en coordonées
    # results = Geocoder.search(@address)
    # #Stocker ces coordonées
    # @user_coordinates = results.first.coordinates
    # #Récuperer tout les polygones et itérer dessus.
    # @districts = District.all
    # @districts.each do |district|
    #   district_coordinates = eval(district.district_coordinates)
    #   next if district_coordinates.empty?

    #   polygon_coordinates = district_coordinates["coordinates"].flatten(1)
    #   # raise if polygon_coordinates.first.first.is_a? Array
    #   # if polygon_coordinates.first.first.is_a? Array
    #   #   polygon_coordinates = polygon_coordinates.flatten(1)
    #   # end
    #   while polygon_coordinates[0][0].is_a?(Array)
    #     polygon_coordinates = polygon_coordinates.flatten(1)
    #   end

    #   points = []
    #   polygon_coordinates.each do |coordinate|
    #     points << Geokit::LatLng.new(coordinate[1], coordinate[0])
    #   end
    #   polygon = Geokit::Polygon.new(points)
    #   if polygon.contains?(Geokit::LatLng.new(@user_coordinates[0], @user_coordinates[1]))
    #     return redirect_to representative_path(district.representative)
    #   end
    # end
    # redirect_to root_path


#Recuperer l'input du user
    #Iterer sur tout les polygones.
    #If user's addrress coordinates are inside the district's, then user's district_id = district
    #----------------------------------------------------------------------------------------------
    #
