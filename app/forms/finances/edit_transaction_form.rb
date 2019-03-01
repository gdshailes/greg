class Finances::EditTransactionForm
  include ActiveModel::Model

  attr_accessor :transaction, :description, :amount, :reconciled, :transaction_date, :bill_id

  delegate :description, :reconciled, :transaction_date, :bill_id, :errors, :to_account, :to_account_id, to: :transaction

  def initialize(transaction = nil)
    @transaction = transaction || Finances::Transaction.new(transaction_date: Date.current)
  end

  def submit(params)
    @params = params
    set_reconciled_difference

    was_reconciled = transaction.reconciled

    transaction.assign_attributes(transaction_params)
    transaction.amount_pence *= -1 unless supporting_params[:deposit] == '1'

    if transaction.valid?
      ActiveRecord::Base.transaction do
        Finances::Bill.find(transaction.bill_id).increment_next_due_at! if transaction.bill_id
        update_reconciled_balances(was_reconciled) unless @reconciled_difference == 0
        transaction.save!
      end
      true
    else
      false
    end
  end

  def amount
    transaction.amount.abs
  end

  def deposit
    transaction.amount > 0
  end

  def to_accounts
    transaction.account.other_accounts
  end


  private


  def set_reconciled_difference
    # Calculate reconciled balance adjustment for the account
    is_reconciled = transaction_params[:reconciled] == '1'
    was_reconciled = transaction.reconciled

    is_balance_payment = transaction_params[:to_account_id].present?
    was_balance_payment = transaction.to_account.present?

    new_value = if is_balance_payment
      Finances::Account.find(transaction_params[:to_account_id].to_s).balance
    else
      transaction_params[:amount].to_money * (supporting_params[:deposit] == '1' ? 1 : -1)
    end
    old_value = transaction.amount

    if is_reconciled || was_reconciled
      @reconciled_difference = is_reconciled ? new_value : 0
      @reconciled_difference -= old_value if was_reconciled
    else
      @reconciled_difference = 0 
    end

  end

  def update_reconciled_balances(was_reconciled)
    transaction.account.update_attributes!(reconciled_balance: (transaction.account.reconciled_balance || 0) + @reconciled_difference)
    return unless transaction.to_account
    if was_reconciled
      transaction.to_account.transactions.unreconciled.update_all(reconciled: transaction.reconciled)
      return unless transaction.reconciled
    end
    update_destination_account_reconciled_balance
  end

  def update_destination_account_reconciled_balance
    transaction.to_account.update_attribute(:reconciled_balance, (transaction.to_account.reconciled_balance || 0) - @reconciled_difference)
  end

  def transaction_params
    @params.permit(:transaction_date, :finances_account_id, :description, :amount, :reconciled, :bill_id, :to_account_id)
  end

  def supporting_params
    @params.permit(:deposit)
  end

end
