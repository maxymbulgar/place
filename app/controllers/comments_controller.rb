class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.author_mail = current_user.email
    @comment.author_ip = request.remote_ip
    @comment.article_id = params[:article_id]

    @comment.save

    redirect_to article_path(@comment.article)
  end


  def destroy
    if current_user.admin? or current_user.editor?
      @comment = Comment.find(params[:id])
      id = @comment.article_id
      @comment.destroy
      redirect_to article_path(id)
    else
      @comment = Comment.find(params[:id])
      id = @comment.article_id
      @comment = nil
      flash[:warning] = t('forms.messages.error')
      redirect_to article_path(id)
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
