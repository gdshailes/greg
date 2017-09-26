class PopulateTransactionDateInFinancesTransactions < ActiveRecord::Migration[5.0]

  class LocalTransaction < ActiveRecord::Base
    self.table_name = 'finances_transactions'
  end

  def up
    LocalTransaction.all.each do |tx|
      tx.update_attributes(transaction_date: tx.created_at)
    end
  end

  def down
  end

end
