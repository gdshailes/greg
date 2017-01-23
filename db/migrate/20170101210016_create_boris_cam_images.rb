class CreateBorisCamImages < ActiveRecord::Migration[5.0]
  def change
    create_table :boris_cam_images do |t|
      t.string :filename
      t.binary :filedata
      t.string :filetype
      t.timestamps
    end
  end
end
