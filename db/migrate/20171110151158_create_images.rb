class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :imageable, polymorphic: true
      t.string :filename
      t.binary :filedata
      t.string :filetype
      t.timestamps null: false
    end

  end
end
