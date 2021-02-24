class LawsController < ApplicationController
  before_action :authenticate_user!, only: [:like]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @laws = Law.all
  end

  def show
    @law = Law.find(params[:id])
  end

  def like
    if current_user.voted_for? @law
      @law.unliked_by current_user
    else
      @law.liked_by current_user
    end
  end
end
