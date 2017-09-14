module RideLog
  class Ride < ApplicationRecord
    has_many :ride_log_images, as: :imageable, dependent: :destroy
    has_one :bike
  end
end