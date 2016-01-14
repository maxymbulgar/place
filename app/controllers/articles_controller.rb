class ArticlesController < ApplicationController

  #if (:admin?)
    #before_action :require_admin, :if => :signed_in?, only: [:new,:edit]  
  #elsif (:author?)
  #  skip_before_action :require_admin, only: [:new, :edit]
  #end

  #before_action :require_editor, only: [:show, :edit]
  #before_action :require_admin, only: [:new, :show, :edit]
  #before_action :redirect_to_root, :if => :not_signed_in?, only: [:new,:edit]

  def index
    @articles = Article.where("publish_at <= :date_now",
  {date_now: Time.now}).order('created_at DESC')
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def preview
    @article = Article.new(article_params)
  end

  def new
    if signed_in?
      if current_user.admin? or current_user.author?
        @article = Article.new
      else
        flash[:warning] = t('forms.messages.error')
        redirect_to '/'
      end
    else
      flash[:warning] = t('forms.messages.error')
      redirect_to '/'
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = t('forms.messages.success')
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    if signed_in?
      if current_user.admin?
        @article = Article.find(params[:id])
      elsif current_user.author?
        @article = Article.find(params[:id])
        if @article.author_email != current_user.email
          @article = nil
          flash[:warning] = t('forms.messages.error')
          redirect_to '/'
        end
      else
        flash[:warning] = t('forms.messages.error')
        redirect_to '/'
      end
    else
      flash[:warning] = t('forms.messages.error')
      redirect_to '/'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.updates_attributes(article_params)
      flash[:success] = t('forms.messages.success')
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

  def article_params
    params.require(:article).permit(:body, :title, :author_email, :publish_at)
  end
  def redirect_to_root
    redirect_to root_path
  end
end
