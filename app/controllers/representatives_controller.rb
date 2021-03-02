require 'json'
require 'open-uri'
require 'rgeo/geo_json'
require 'geokit'

class RepresentativesController < ApplicationController
  include ScrappingRepresentativeConcern

  def show
    @representative = Representative.find(params[:id])
    @name = "#{@representative.first_name} #{@representative.last_name}"
    @years_old = Date.today.year - @representative.birth_date.year
    @laws = Law.all
    scrapping
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
