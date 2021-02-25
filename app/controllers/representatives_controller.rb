class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find(params[:id])
  end

  def search
    @address = params
    results = Geocoder.search(@address)
    results.first.coordinates
=> [48.856614, 2.3522219]  # latitude and longitude
    redirect_to root_path
  end
end
