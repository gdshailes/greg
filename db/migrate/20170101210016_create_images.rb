class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :image do |t|
      t.integer :number
      t.binary :image
    end
  end
end
