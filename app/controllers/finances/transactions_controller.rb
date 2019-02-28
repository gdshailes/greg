class Finances::TransactionsController < Finances::BaseController

  before_action :set_transaction, only: [:edit, :update, :destroy]

  respond_to :html

  def index
  end

  def new
    @transaction_form = Finances::EditTransactionForm.new(Finances::Transaction.new(account: @account, transaction_date: Date.current))
  end

  def edit
    @transaction_form = Finances::EditTransactionForm.new(@transaction)
  end

  def create
    @transaction_form = Finances::EditTransactionForm.new(Finances::Transaction.new(account: @account))
    if @transaction_form.submit(transaction_form_params)
      redirect_to finances_account_path @account
    else
      render 'finances/transactions/new'
    end
  end

  def update
    @transaction_form = Finances::EditTransactionForm.new(@transaction)
    if @transaction_form.submit(transaction_form_params)
      redirect_to finances_account_path @account
    else
      render 'finances/transactions/edit'
    end
  end

  def destroy
    @account.update_attributes!(reconciled_balance: @transaction.amount * -1) if @transaction.reconciled?
    if @transaction.destroy
      redirect_to finances_account_path(@account)
    end
  end

  def export
    render csv: @account.transactions.order(:transaction_date)
  end


  private


  def set_transaction
    @transaction = @account.transactions.find(params[:id])
  end

  def transaction_form_params
    params.require(:finances_edit_transaction_form).permit(:transaction_date, :description, :deposit, :to_account, :amount, :reconciled, :bill_id)
  end

end
