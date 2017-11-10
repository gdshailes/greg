class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.references :imageable, polymorphic: true
      t.timestamps null: false
    end

    add_column :images, :original_filename, :string
    add_column :images, :content_type, :string
  end
end
