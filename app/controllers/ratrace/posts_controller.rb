class Ratrace::PostsController < Ratrace::BaseController

  require 'koala'

  before_action :authenticate_admin!, except: :get_next

  before_action :set_new_post, only: [:index]
  before_action :set_posts, only: [:index, :get_next]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_latest_post, only: [:post_to_facebook]

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

    if @post.save && params[:post_to_facebook] == '1'
      redirect_to Facebook.new(post_to_fb_url).fb_permissions_url
    end
  end

  def post_to_facebook
    access_token = Facebook.new(post_to_fb_url).oauth.get_access_token(params[:code])
    @graph = Koala::Facebook::API.new(access_token)
    @graph.put_wall_post("There's a new update on our RatRace training progress! It's titled '#{@post.title}', and you can read and comment on it now at " + ratrace_url)
    redirect_to ratrace_posts_url
  end

  def get_next
    render :get_next, layout: false
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


  def set_new_post
    @post = Ratrace::Post.new(user: current_user)
  end

  def set_posts
    if params[:post_id]
      @posts = Ratrace::Post.where('id < ?', params[:post_id]).limit(10)
    else
      @posts = Ratrace::Post.all.limit(4)
    end
  end

  def set_post
    @post = Ratrace::Post.find(params[:post_id] || params[:id])
  end

  def set_latest_post
    @post = Ratrace::Post.first
  end

  def post_params
    params.require(:ratrace_post).permit(:user_id, :title, :body)
  end

  def post_to_fb_url
    ratrace_post_to_facebook_url
  end

end
