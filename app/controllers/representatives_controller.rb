class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find(params[:id])
  end

  def search
    
  end
end
