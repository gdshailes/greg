class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :filename
      t.binary :filedata
      t.string :filetype
      t.timestamps
    end
  end
end
