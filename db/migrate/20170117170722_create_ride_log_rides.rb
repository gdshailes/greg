class CreateRideLogRides < ActiveRecord::Migration[5.0]
  def change
    create_table :ride_log_rides do |t|
      t.belongs_to :ride_log_bike
      t.string :name, :default => 'New Ride'
      t.datetime :date
      t.timestamps
    end
  end
end
