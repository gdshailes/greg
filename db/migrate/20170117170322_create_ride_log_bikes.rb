class CreateRideLogBikes < ActiveRecord::Migration[5.0]
  def change
    create_table :ride_log_bikes do |t|
      t.string :name, :default => 'New Bike'
      t.string :details
      t.boolean :current, :default => true
      t.timestamps
    end
  end
end
