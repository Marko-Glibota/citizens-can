class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find(params[:id])
  end

  def search
    @address = params
    redirect_to root_path
  end
end
