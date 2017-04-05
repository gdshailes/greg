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

    # Notify any subscribers
    ApiSubscription.where(event: :new_ride_created).each do |sub|
      # Post the subscriber details of this new ride
      response = HTTParty.post(
        sub.target_url,
        :body => {:date => ride.date,
                  :name => ride.name,
                }.to_json,
        :headers => {'Content-Type' => 'application/json'}
      )
    end

    redirect_to action: :index
  end

  def show
    @ride = RideLogRide.find(params[:id])
  end

end