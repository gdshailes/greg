class Api::PingController < ActionController::Base

  include JsonResponse
  before_action :restrict_api_access

  def index
    head :ok
  end

end