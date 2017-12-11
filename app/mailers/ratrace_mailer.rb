class RatraceMailer < ApplicationMailer

  def self.send_test_email(to:)
    mail = test_email(to)
    mail.deliver_now
    mail
  end

  def test_email(to)
    mail(to: to, subject: "Test email from Rails app")
  end

  def new_comment(comment:)
    unless comment.user == comment.commentable.user
      @commenter = comment.user.display_name
      @post_title = comment.commentable.title
      mail(to: comment.commentable.user.email, subject: "#{@commenter} has just commented on your post '#{@post_title}")
    end
  end

  def also_commented(to:, comment:)
    @commenter = comment.user.display_name
    @post_title = comment.commentable.title
    mail(to: to, subject: "#{@commenter} has also commented on the post '#{@post_title}")
  end

  def self.send_new_comment(comment:)
    mails = []
    mail = new_comment(comment: comment)
    mail.deliver_now unless mail.nil?
    comment.commentable.comments.reject{|c| c.user_id == comment.user_id}.pluck(:user_id).uniq.each do |user_id|
      if User.exists?(user_id)
        mail = also_commented(to: User.find(user_id).email, comment: comment)
        mail.deliver_now
        mails << mail
      end
    end
    mails
  end
end