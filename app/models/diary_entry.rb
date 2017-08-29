class DiaryEntry < ApplicationRecord

  def entry_date
    created_at.strftime("#{created_at.day.ordinalize} %B %y")
  end

end
