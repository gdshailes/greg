
class ::CommentDecorator

  attr_reader :comment

  delegate :created_at, :user, to: :comment

  def initialize(comment)
    @comment = comment
  end

  def commenter_name
    comment.user.first_name || comment.user.name || comment.user.email
  end

  def humanized_recency
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
      created_at.strftime("%A")
    when created_at > (Time.current.beginning_of_year)
      created_at.strftime("#{created_at.day.ordinalize} %B")
    else
      created_at.strftime("%B %Y")
    end
  end

end