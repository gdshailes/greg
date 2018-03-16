class RatraceController < ApplicationController

  def index
    @posts = Ratrace::Post.order(created_at: :desc).limit(2)
    @admin = is_admin?
  end

end