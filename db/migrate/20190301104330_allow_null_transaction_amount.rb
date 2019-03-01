class AllowNullTransactionAmount < ActiveRecord::Migration[5.0]
  def up
    change_column :finances_transactions, :amount_pence, :integer, null: true
  end
end
