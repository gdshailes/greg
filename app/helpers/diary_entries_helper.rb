module DiaryEntriesHelper
  def get_diary_entries
    @entries = current_user.diary_entries.all.order(created_at: :desc)
  end
end