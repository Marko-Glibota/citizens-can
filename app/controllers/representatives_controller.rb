class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find(params[:id])
  end

  def search
    @address = params[:search][:address]
    results = Geocoder.search(@address)
    @coordinates = results.first.coordinates
    redirect_to root_path
  end
end
