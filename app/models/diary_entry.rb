class DiaryEntry < ApplicationRecord

  def entry_date
    if persisted?
      created_at.strftime("#{created_at.day.ordinalize} %B %Y")
    else
      'New Entry'
    end
  end

end
