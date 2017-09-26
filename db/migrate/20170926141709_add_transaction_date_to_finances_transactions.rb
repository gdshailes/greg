class AddTransactionDateToFinancesTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :finances_transactions, :transaction_date, :date
  end
end
