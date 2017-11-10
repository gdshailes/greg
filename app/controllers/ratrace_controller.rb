class RatraceController < ActionController::Base

  def index
    @posts = Ratrace::Post.all
  end

end