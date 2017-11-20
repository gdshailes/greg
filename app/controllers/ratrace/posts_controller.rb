class Ratrace::PostsController < Ratrace::BaseController

  require 'koala'


  before_action :authenticate_admin!

  before_action :set_posts, only: :index
  before_action :set_post, only: [:edit, :update, :destroy, :post_to_facebook]

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
      img.uploaded_file params[:ratrace_post][:image], 1000, 3000
      if img.filetype != "image/jpeg"
        head :unsupported_media_type
      else
        img.save!
        @post.images << img
      end
    end

    if @post.save!
      redirect_to Facebook.new(post_to_fb_url).fb_permissions_url
    end

  end

  def post_to_facebook
    access_token = Facebook.new(post_to_fb_url).oauth.get_access_token(params[:code])

    @graph = Koala::Facebook::API.new(access_token)
    @graph.put_wall_post("I've just written a new update on our RatRace training progress, titled '#{@post.title}'. You can read and comment on it now at " + ratrace_posts_url)
    redirect_to ratrace_url

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
      @post = Ratrace::Post.find(params[:post_id] || params[:id])
    end

    def post_params
      params.require(:ratrace_post).permit(:user_id, :title, :body)
    end

    def post_to_fb_url
      ratrace_post_post_to_facebook_url(@post)
    end

end
