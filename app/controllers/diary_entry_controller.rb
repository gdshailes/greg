class DiaryEntryController < ActionController::Base

  before_action :authenticate_user!
  before_action :get_diary_entries

  include GetDiaryEntriesConcern

  def index
    @latest = current_user.diary_entries.order(created_at: :desc).first
  end

  def new
    @entry = DiaryEntry.new(created_at: Time.current, user_id: current_user.id)
  end

  def show
    @entry = current_user.diary_entries.find(params[:id])
  end

  def create
    @entry = current_user.diary_entries.new(diary_entry_params)
    if @entry.valid?
      @entry.save
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
    @entry.update(diary_entry_params)
    if @entry.valid?
      @entry.save
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

  def diary_entry_params
    params.require(:diary_entry).permit(:title, :body)
  end

end
