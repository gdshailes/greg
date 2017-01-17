class RideLogImage < ApplicationRecord
  belongs_to :imageable, polymorphic: true
end
