class RepresentativesVotesController < ApplicationController
  def new
    @representative_vote = RepresentativesVote.new
  end

  def create
    @representative_vote = RepresentativesVote.new(vote_params)
    @representative_vote.save
  end

  private

  def vote_params
    params.require(:representatives_vote).permit(:voting_status)
  end
end
