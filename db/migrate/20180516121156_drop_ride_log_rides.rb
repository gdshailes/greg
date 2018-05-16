class DropRideLogRides < ActiveRecord::Migration[5.0]
  def up
    drop_table :ride_log_rides
  end
  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
