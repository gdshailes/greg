class Ratrace::CommentsController < Ratrace::BaseController

  before_action :authenticate_user!

  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:update, :destroy]

  def create
    unless params[:ratrace_post_comment][:comment].blank?
      comment = @post.comments.build
      comment.user = current_user
      comment.comment = params[:ratrace_post_comment][:comment]
      comment.save!
    end
    redirect_to ratrace_path
  end

  def destroy
    if @comment.destroy
      redirect_to ratrace_path
    end
  end

  private

  def set_post
    @post = Ratrace::Post.find(params[:post_id])
  end

  def set_comment
    @comment = ::Comment.find(params[:comment_id] || params[:id])
  end

end