class AddUserIdToDiaryEntry < ActiveRecord::Migration[5.0]
  def change
    add_reference :diary_entries, :user, index: true
  end
end
