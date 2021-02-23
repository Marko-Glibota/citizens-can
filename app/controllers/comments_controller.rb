class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @law = Law.new.find(params[:law_id])
    @comment.law = Law.new.find(params[:law_id])
    @comment.user = current_user
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.law = Law.new.find(params[:law_id])
    @law = @comment.law
    @comment.user = current_user
    if @comment.save
      redirect_to law_path(@comment.law)
    else
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :content, :voting_status)
  end
end
