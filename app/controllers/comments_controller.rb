class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.law = Law.find(params[:law_id])
    @law = @comment.law
    @comment.user = current_user
    @comment.save
    redirect_to law_path(@law)
  end

  def for
    @comment = Comment.find(params[:id])
    @comment.update(status: "for")
    redirect_to law_path(@law)
  end

  def against
    @comment = Comment.find(params[:id])
    @comment.update(status: "against")
    redirect_to law_path(@law)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :voting_status)
  end
end
