class DropRideLogImages < ActiveRecord::Migration[5.0]
  def up
    drop_table :ride_log_images
  end
  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
