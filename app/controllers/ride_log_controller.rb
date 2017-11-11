class RideLogController < ApplicationController

  def index
    @latest_ride = RideLog::Ride.order(date: :desc).first
  end

end
