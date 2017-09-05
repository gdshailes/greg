class RideLogController < ActionController::Base

  def index
    @latest_ride = RideLog::Ride.order(date: :desc).first
  end

end
