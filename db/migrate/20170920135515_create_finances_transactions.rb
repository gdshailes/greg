class CreateFinancesTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :finances_transactions do |t|
      t.belongs_to :account, index: true
      t.string :description
      t.money :amount
      t.boolean :reconciled
      t.timestamps null: false
    end
  end
end
