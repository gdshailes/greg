module RideLog
  class RideController < ActionController::Base
    protect_from_forgery with: :exception

    def index
      # Render ride_log home page.
      @rides = RideLog::Ride.all
    end

  end
end