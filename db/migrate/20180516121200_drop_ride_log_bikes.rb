class DropRideLogBikes < ActiveRecord::Migration[5.0]
  def up
    drop_table :ride_log_bikes
  end
  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
