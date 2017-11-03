class TestController < ActionController::Base

  def index
    Test.current_id = params[:t]
    @w = params[:w]
    sleep(@w.to_i)
    @t = Test.current_id
  end

end