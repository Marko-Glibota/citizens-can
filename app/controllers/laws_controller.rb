class LawsController < ApplicationController
  before_action :set_law, only: [:show, :upvote, :downvote, :for, :against]
  before_action :authenticate_user!, only: [:upvote, :downvote]
  skip_before_action :authenticate_user!, only: [:index, :show]
  # Pagy
  include Pagy::Backend

  def index
    @laws = Law.all

    if params[:query].present?
      @laws = Law.where("title ILIKE ?", "%#{params[:query]}%")
    else
      @laws = Law.all
    end

    @pagy, @laws = pagy(@laws.order(created_at: :desc), items: 10)
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
