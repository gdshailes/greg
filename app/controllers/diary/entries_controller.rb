class Diary::EntriesController < ApplicationController

  before_action :authenticate_user!
  before_action :get_entries

  def index
    @latest = current_user.diary_entries.order(created_at: :desc).first
  end

  def new
    @entry = Diary::Entry.new(created_at: Time.current, user_id: current_user.id)
  end

  def show
    @entry = current_user.diary_entries.find(params[:id])
  end

  def create
    @entry = current_user.diary_entries.new(entry_params)
    if @entry.valid? and @entry.save
      redirect_to action: :index
    else
      redirect_to 'create'
    end
  end

  def edit
    @entry = current_user.diary_entries.find(params[:id])
  end

  def update
    @entry = current_user.diary_entries.find(params[:id])
    @entry.update(entry_params)
    if @entry.valid? and @entry.save
      redirect_to action: :index
    else
      redirect_to 'edit'
    end
  end

  def destroy
    @entry = current_user.diary_entries.find(params[:id])
    @entry.destroy!
    redirect_to action: :index
  end


  private


  def get_entries
    @entries = current_user.diary_entries.all.order(created_at: :desc)
  end

  def entry_params
    params.require(:diary_entry).permit(:title, :body)
  end

end
