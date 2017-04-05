class Api::NewRideController < ActionController::Base

  include JsonResponse
  respond_to :json

  def new_ride
    json_response("new ride")
  end

end