class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.author_mail = current_user.email
    @comment.author_ip = request.remote_ip
    @comment.article_id = params[:article_id]

    @comment.save

    redirect_to article_path(@comment.article)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
