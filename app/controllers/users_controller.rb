class UsersController < ApplicationController
  before_action :redirect_to_root, :if => :not_signed_in?, only: [:show,:edit,:edit_role]
  before_action :require_admin, only: [:edit_role, :update_role]
  before_action :correct_user,   only: [:edit, :update]
  def index
    @users = User.all
  end
  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.about = params[:user][:about]
    if @user.save
      sign_in @user
      flash[:success] = t('forms.messages.success')
      redirect_to "/"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.about = params[:user][:about]
    if @user.update_attributes(user_params)
      flash[:success] = t('forms.messages.success')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit_role
    @user = User.find(params[:id])
  end

  def update_role
    @user = User.find(params[:id])
    @user.role = params[:user][:role]
    @user.save(validate: false)
    flash[:success] = t('forms.messages.success')
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end
end
