module RideLog
  class Ride < ApplicationRecord
    has_many :ride_log_images, as: :imageable, dependent: :destroy


    def bike
      RideLog::Bike.find(ride_log_bike_id)
    end


  end
end