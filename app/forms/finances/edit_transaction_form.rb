class Finances::EditTransactionForm
  include ActiveModel::Model

  attr_accessor :description, :amount, :reconciled

  delegate :description, :reconciled, to: :transaction

  def initialize(transaction)
    @transaction = transaction
  end

  def submit(params)
    @params = params
    @transaction.update_attributes(transaction_params)
    unless params[:deposit] == '1'
      @transaction.amount = @transaction.amount * -1
    end
    if @transaction.valid?
      @transaction.save!
    end
  end

  def transaction
    @transaction
  end

  def amount
    @transaction.amount.abs
  end

  def deposit
    @transaction.amount > 0 ? true : false
  end

  private

  def transaction_params
    @params.permit(:finances_account_id, :description, :amount, :reconciled)
  end

end