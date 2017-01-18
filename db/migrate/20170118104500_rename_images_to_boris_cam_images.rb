class RenameImagesToBorisCamImages < ActiveRecord::Migration
  def change
    rename_table :images, :boris_cam_images
  end
end