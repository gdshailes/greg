class Ratrace::PostsController < Ratrace::BaseController

  before_action :authenticate_user!
  before_action :set_posts, only: :index

  def index
    respond_with(@post)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Ratrace::Post.new(user: current_user)
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Ratrace::Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to ratrace_posts_url
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private

    def set_posts
      @posts = Ratrace::Post.all
    end

    def post_params
      params.require(:ratrace_post).permit(:user_id, :title, :body)
    end

end
