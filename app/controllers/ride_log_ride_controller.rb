class RideLogRideController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    # Show all rides
    @rides = RideLogRide.all

  end

  def new
    # Render 'New ride' form - if logged in
    @bikes = RideLogBike.all
  end

  def create
    p = params[:ride_log_ride]
    ride = RideLogRide.new(name: p[:name], date: p[:date])
    ride.ride_log_bike_id = p[:bike_id]
    ride.save
    redirect_to action: :index
  end

  def show
    @ride = RideLogRide.find(params[:id])
  end

end