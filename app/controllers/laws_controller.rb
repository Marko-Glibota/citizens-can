class LawsController < ApplicationController
  before_action :set_law, only: [:show, :upvote, :downvote, :for, :against]
  before_action :authenticate_user!, only: [:upvote, :downvote]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @laws = Law.all
  end

  def show
  end

  def upvote
    @law.upvote_from current_user
    redirect_to laws_path
  end

  def downvote
    @law.downvote_from current_user
    redirect_to laws_path
  end

  def for
    @law.upvote_from @current_user
    redirect_to law_path(law)
  end

  def against
    @law.downvote_from current_user
    redirect_to law_path(law)
  end

  private

  def set_law
    @law = Law.find(params[:id])
  end
end
