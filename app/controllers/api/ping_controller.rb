class Api::PingController < ActionController::Base

  include JsonResponse
  before_filter :restrict_api_access

  def index
    head :ok
  end

end