class Api::RideLogRideController < ActionController::Base

  include JsonResponse
  before_action :restrict_api_access
  respond_to :json

  def index
    json_response(RideLogRide.all)
  end

  def create
    json_response("new ride")
  end

end