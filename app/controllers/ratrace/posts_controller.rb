class Ratrace::PostsController < Ratrace::BaseController

  before_action :authenticate_admin!

  before_action :set_posts, only: :index
  before_action :set_post, only: [:edit, :update]

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

    unless params[:ratrace_post][:image].blank?
      img = Image.new
      img.uploaded_file params[:ratrace_post][:image]
      if img.filetype != "image/jpeg"
        head :unsupported_media_type
      else
        img.save!
        @post.images << img
      end
    end

    if @post.save!
      redirect_to ratrace_url
    end

  end

  def update
    @post.update(post_params)
    redirect_to ratrace_posts_url
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private

    def set_posts
      @posts = Ratrace::Post.all
    end

    def set_post
      @post = Ratrace::Post.find(params[:id])
    end

    def post_params
      params.require(:ratrace_post).permit(:user_id, :title, :body)
    end

end
