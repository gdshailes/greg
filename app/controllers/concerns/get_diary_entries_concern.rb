module GetDiaryEntriesConcern

  def get_diary_entries
    @entries = DiaryEntry.all.order(created_at: :desc)
  end

end