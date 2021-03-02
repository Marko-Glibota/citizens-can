class LawsController < ApplicationController
  before_action :set_law, only: [:show, :upvote, :downvote, :for, :against]
  before_action :authenticate_user!, only: [:upvote, :downvote]
  skip_before_action :authenticate_user!, only: [:index, :show]
  # Pagy
  include Pagy::Backend

  def index
    @laws = Law.order(date: :desc)

    if params[:query].present?
      @laws = @laws.where("title ILIKE ?", "%#{params[:query]}%")
    end

    @pagy, @laws = pagy(@laws, items: 10)

    @most_upvoted_laws = Law.order(:cached_votes_up => :desc).first(10)
    @most_downvoted_laws = Law.order(:cached_votes_down => :desc).first(5)
  end

  def show
    @comment = Comment.new
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
    @law.upvote_from current_user
    redirect_to law_path(@law)
  end

  def against
    @law.downvote_from current_user
    redirect_to law_path(@law)
  end

  private

  def set_law
    @law = Law.find(params[:id])
  end
end
