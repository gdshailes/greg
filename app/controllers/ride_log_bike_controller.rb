class RideLogBikeController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    # Render Bikes home page - show all bikes
    @bikes = RideLogBike.all
  end

  def new
    # Render 'New bike' form - if logged in
  end

  def create
    # Create a new bike - if logged in
    p = params[:ride_log_bike]
    bike = RideLogBike.new(name: p[:name], details: p[:details])
    bike.save
    redirect_to action: 'index'
  end

  def show
    # Show a bike
    @bike = RideLogBike.find(params[:id])
  end

  def edit
    # Render 'Edit Bike' form - if logged in
    @bike = RideLogBike.find(params[:id])
  end

  def update
    # Update a bike - if logged in
    @bike = RideLogBike.find(params[:id])
    if @bike.update_attributes(bike_params)
      # Handle a successful update.
      redirect_to action: 'index'
    else
      render 'edit'
    end  end

  def destroy
    # Remove a bike - if logged in
    @bike = RideLogBike.find(params[:id])
    if @bike.destroy!
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  private

  def bike_params
    params.require(:ride_log_bike).permit(:name, :details)
  end

end