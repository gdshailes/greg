class CreateRideLogImages < ActiveRecord::Migration[5.0]
  def change
    create_table :ride_log_images do |t|
      t.string :title
      t.binary :image
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
