class Ratrace::Post < ApplicationRecord

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  scope :for_user, -> (user) { where(user: user) }

  def pretty_created_at
    created_at.strftime("#{created_at.day.ordinalize} %B %Y")
  end

  def short_created_at
    created_at.strftime('%e/%m/%Y')
  end

  def formatted_body
    text = ''
    self.body.split('\n').collect.each do | para |
      if para != ''
        para = para.gsub('\r', '')
        para = "<p>#{para}</p>"
        text += para
      end
    end
    text
  end

  def image
    images.first
  end

  def post_to_facebook
    return new_record?
  end

end
