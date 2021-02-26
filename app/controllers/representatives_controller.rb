require 'json'
require 'open-uri'
require 'csv'
require 'date'
require 'nokogiri'

class RepresentativesController < ApplicationController

   include ScrappingRepresentativeConcern
  def show
    @representative = Representative.find(params[:id])
    @name = "#{@representative.first_name} #{@representative.last_name}"
    scrapping


  end

  def search
    @address = params[:search]
    results = Geocoder.search(@address)
    @coordinates = results.first.coordinates
    redirect_to root_path
  end
end
