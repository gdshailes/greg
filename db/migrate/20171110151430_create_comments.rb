class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment_by
      t.string :comment
      t.references :commentable, polymorphic: true
      t.timestamps null: false
    end
  end
end
