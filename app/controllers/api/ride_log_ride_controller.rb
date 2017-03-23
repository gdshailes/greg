class Api::RideLogRideController < ActionController::Base

  include JsonResponse
  before_filter :restrict_api_access
  respond_to :json

  def index
    binding.pry
    json_response(RideLogRide.all)
  end

end