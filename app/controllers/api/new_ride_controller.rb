class Api::NewRideController < ActionController::Base

  include JsonResponse
  respond_to :json

  def index
  end

  def new_ride
    binding.pry
    bike = RideLogBike.new(name:'New Ride!')
    bike.save!
    json_response("new ride")
  end

end