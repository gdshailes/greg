class CreateFinancesBills < ActiveRecord::Migration[5.0]
  def change
    create_table :finances_bills do |t|
      t.belongs_to :account, index: true
      t.string :description, null: false
      t.monetize :amount, null: false
      t.string :frequency, null: false
      t.integer :interval, null: false
      t.date :next_due_at, null: false

      t.timestamps null: false
    end
  end
end
