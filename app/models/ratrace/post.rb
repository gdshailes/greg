class Ratrace::Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  scope :for_user, -> (user) { where(user: user) }

  def pretty_created_at
    created_at.strftime("#{created_at.day.ordinalize} %B %Y")
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
