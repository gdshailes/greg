class RatraceController < ApplicationController

  def index
    @posts = Ratrace::Post.order(created_at: :desc).last(10)
    if is_admin?
      @is_admin = true
    end
  end

end