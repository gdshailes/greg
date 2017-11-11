class RatraceController < ApplicationController

  def index
    @posts = Ratrace::Post.all
    if is_admin?
      @is_admin = true
    end
  end

end