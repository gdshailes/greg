class RideLog::RideController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @rides = RideLog::Ride.all
  end

  def new
    # Render 'New ride' form - if logged in
    @bikes = RideLog::Bike.all
  end

  def create
    # Create a new ride - if logged in
    p = params[:ride_log_ride]
    ride = RideLog::Ride.new(name: p[:name], bike_id: p[:bike_id], date: p[:date])
    ride.save
    redirect_to action: :index
  end

  def show
    # Show a ride
    @ride = RideLog::Ride.find(params[:id])
  end

  def edit
    # Render 'Edit Ride' form - if logged in
    @bikes = RideLog::Bike.all
    @ride = RideLog::Ride.find(params[:id])
  end

  def update
    # Update a ride - if logged in
    @ride = RideLog::Ride.find(params[:id])
    if @ride.update_attributes(ride_params)
      # Handle a successful update.
      redirect_to action: :index
    else
      render 'edit'
    end
  end

  def destroy
    # Remove a ride - if logged in
    @ride = RideLog::Ride.find(params[:id])
    if @ride.destroy!
      redirect_to action: :index
      flash[:error] = 'Deleted!'
    else
      render 'edit'
    end
  end

  private

  def ride_params
    params.require(:ride_log_ride).permit(:name, :date, :bike_id)
  end
end