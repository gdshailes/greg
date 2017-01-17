class CreateRideLogBikes < ActiveRecord::Migration[5.0]
  def change
    create_table :ride_log_bikes do |t|
      t.string :name
      t.string :details

      t.timestamps
    end
  end
end
