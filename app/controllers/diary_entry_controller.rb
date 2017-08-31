class DiaryEntryController < ActionController::Base
  prepend_before_action :get_diary_entries

  include GetDiaryEntriesConcern

  def index
    @latest = DiaryEntry.order(created_at: :desc).first
  end

  def new
    @entry = DiaryEntry.new(created_at: Time.current)
  end

  def show
    @entry = DiaryEntry.find(params[:id])
  end

  def create
    @entry = DiaryEntry.new(diary_entry_params)
    if @entry.valid?
      @entry.save
      redirect_to action: :index
    else
      redirect_to 'create'
    end
  end

  def edit
    @entry = DiaryEntry.find(params[:id])
  end

  def update
    @entry = DiaryEntry.find(params[:id])
    @entry.update(diary_entry_params)
    if @entry.valid?
      @entry.save
      redirect_to action: :index
    else
      redirect_to 'edit'
    end
  end

  def destroy
    @entry = DiaryEntry.find(params[:id])
    @entry.destroy!
    redirect_to action: :index
  end

  private

  def diary_entry_params
    params.require(:diary_entry).permit(:title, :body)
  end

end