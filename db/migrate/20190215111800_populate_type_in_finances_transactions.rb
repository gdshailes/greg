class PopulateTypeInFinancesTransactions < ActiveRecord::Migration[5.0]

  class LocalTransaction < ActiveRecord::Base
    self.table_name = 'finances_transactions'
  end

  def up
    LocalTransaction.all.each do |tx|
      if tx.reconciled
        tx.update_attribute(:type, 'Finances::Transaction::Reconciled')
      else
        tx.update_attribute(:type, 'Finances::Transaction::Basic')
      end
    end
  end

  def down
  end

end