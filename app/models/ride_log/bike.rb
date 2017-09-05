module RideLog
  class Bike < ApplicationRecord
    has_many :ride_log_rides, dependent: :destroy
    has_many :ride_log_images, as: :imageable, dependent: :destroy
  end
end