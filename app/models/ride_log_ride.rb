class RideLogRide < ApplicationRecord
  has_many :ride_log_images, as: :imageable, dependent: :destroy


  def bike
    RideLogBike.find(ride_log_bike_id)
  end


end
