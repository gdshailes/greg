
class ::CommentDecorator

  attr_reader :comment

  delegate :created_at, :user, to: :comment

  def initialize(comment)
    @comment = comment
  end

  def commenter_name
    user.display_name
  end

  def humanized_recency
    case
    when created_at > 10.minutes.ago
      'just now'
    when created_at > 1.hour.ago
      'within the last hour'
    when created_at > 3.hours.ago
      'two or three hours ago'
    when created_at > Time.current.beginning_of_day
      'earlier today'
    when created_at > (Time.current - 1.day).beginning_of_day
      'yesterday'
    when created_at > (Time.current - 5.days).beginning_of_day
      created_at.strftime('%A')
    when created_at > (Time.current.beginning_of_year)
      created_at.strftime("#{created_at.day.ordinalize} %B")
    else
      created_at.strftime('%B %Y')
    end
  end

end