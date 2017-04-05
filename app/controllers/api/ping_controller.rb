class Api::PingController < ActionController::Base

  include JsonResponse
  before_filter :restrict_api_access

  def index
    Rails.logger.info(request.env)
    head :ok
  end

end