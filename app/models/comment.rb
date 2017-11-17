class Comment < ActiveRecord::Base

  belongs_to :user

  default_scope -> { order(:created_at) }

  def when
    case
    when created_at > 10.minutes.ago
      "Just now"
    when created_at > 1.hour.ago
      "within the last hour"
    when created_at > 3.hours.ago
      "Two or three hours ago"
    when created_at > Time.current.beginning_of_day
      "Earlier today"
    when created_at > (Time.current - 1.day).beginning_of_day
      "Yesterday"
    when created_at > (Time.current - 7.days).beginning_of_day
      "(dayname)"
    else
      "(dd/mm/yyyy)"
    end
  end

end
