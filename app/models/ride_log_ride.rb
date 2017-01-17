class RideLogRide < ApplicationRecord
  has_many :ride_log_images, as: :imageable, dependent: :destroy
end
