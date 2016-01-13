class PollsController < ApplicationController
  def index
    @polls = Poll.all
  end

  def new
    @poll = Poll.new
  end

  def show
    @poll = Poll.includes(:vote_options).find_by_id(params[:id])
  end

  def create
    @poll = Poll.new(poll_params)
    if @poll.save
      flash[:success] = t('forms.messages.success')
      redirect_to polls_path
    else
      render 'new'
    end
  end

  def edit
    @poll = Poll.find_by_id(params[:id])
  end

  def update
    @poll = Poll.find_by_id(params[:id])
    if @poll.update_attributes(poll_params)
      flash[:success] = t('forms.messages.success')
      redirect_to polls_path
    else
      render 'edit'
    end
  end

  def destroy
    @poll = Poll.find_by_id(params[:id])
    if @poll.destroy
      flash[:success] = t('forms.messages.success')
    else
      flash[:warning] = t('forms.messages.error')
    end
    redirect_to polls_path
  end

  private

  def poll_params
    params.require(:poll).permit(:topic, vote_options_attributes: [:id, :title, :_destroy])
  end
end