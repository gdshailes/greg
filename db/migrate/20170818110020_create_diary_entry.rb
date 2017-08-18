class CreateDiaryEntry < ActiveRecord::Migration[5.0]
  def change
    create_table :diary_entries do |t|
      t.string :title
      t.text   :body
      t.timestamps
    end
  end
end
