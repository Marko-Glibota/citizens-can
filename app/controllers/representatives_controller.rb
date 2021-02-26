require 'json'

class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find(params[:id])
     url = "https://www.nosdeputes.fr/synthese/data/json"
     info_deputes_serialized = open(url).read
     info_deputes = JSON.parse(info_deputes_serialized)
  end

  def search
    @address = params[:search]
    results = Geocoder.search(@address)
    @coordinates = results.first.coordinates
    redirect_to root_path
  end
end
