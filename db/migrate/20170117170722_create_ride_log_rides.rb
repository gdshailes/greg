class CreateRideLogRides < ActiveRecord::Migration[5.0]
  def change
    create_table :ride_log_rides do |t|
      t.string :name
      t.datetime :date

      t.timestamps
    end
  end
end
