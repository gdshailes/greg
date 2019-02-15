class RemoveReconciledFromFinancesTransactions < ActiveRecord::Migration[5.0]

  def change
    remove_column :finances_transactions, :reconciled, :boolean
  end

end