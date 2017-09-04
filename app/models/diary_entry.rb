class DiaryEntry < ApplicationRecord

  def entry_date
    if persisted?
      created_at.strftime("#{created_at.day.ordinalize} %B %Y")
    else
      'New Entry'
    end
  end

  def formatted_body
    text = ''
    self.body.split("\n").collect.each do | para |
      if para != ''
        para = para.gsub('\r', '')
        para = "<p>#{para}</p>"
        text += para
      end
    end
    text
  end
end