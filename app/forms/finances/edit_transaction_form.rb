class Finances::EditTransactionForm
  include ActiveModel::Model

  attr_accessor :description, :amount, :reconciled, :transaction_date, :bill_id

  delegate :description, :reconciled, :transaction_date, :bill_id, :errors, to: :transaction

  def initialize(transaction)
    @transaction = transaction
  end

  def submit(params)
    @params = params
    rd = reconciled_difference
    @transaction.assign_attributes(transaction_params)
    @transaction.amount *= -1 unless supporting_params[:deposit] == "1"
    if @transaction.valid?
      @transaction.account.update_attributes!(reconciled_balance: (@transaction.account.reconciled_balance || 0) + rd)
      @transaction.save!
      if @transaction.bill_id
        Finances::Bill.find(@transaction.bill_id).increment_next_due_at!
      end
      true
    else
      false
    end
  end

  def transaction
    @transaction
  end

  def amount
    @transaction.amount.abs
  end

  def deposit
    @transaction.amount > 0
  end


  private


  def reconciled_difference
    # Calculate reconciled balance adjustment for the account
    new_amount = transaction_params[:amount].to_money
    new_amount *= -1 unless supporting_params[:deposit] == "1"
    old_amount = @transaction.amount || 0

    if transaction_params[:reconciled] == "1"
      if @transaction.new_record? || @transaction.reconciled? == false
        new_amount
      else
        new_amount - old_amount
      end
    else
      if @transaction.reconciled?
        old_amount * -1
      else
        0
      end
    end
  end

  def transaction_params
    @params.permit(:transaction_date, :finances_account_id, :description, :amount, :reconciled, :bill_id)
  end

  def supporting_params
    @params.permit(:deposit)
  end

end
