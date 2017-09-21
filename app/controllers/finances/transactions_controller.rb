class Finances::TransactionsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_account
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_transactions

  respond_to :html

  def index
  end

  def show
    respond_with(@transaction)
  end

  def new
    @transaction = Finances::Transaction.new(account: @account, description: "New Transaction")
    respond_with(@transaction)
  end

  def edit
  end

  def create
    @transaction = Finances::Transaction.new(transaction_params)
    @transaction.account_id = @account.id
    if @transaction.save
      redirect_to finances_account_path @account
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to finances_account_path @account
    end
  end

  def destroy
    if @transaction.destroy
      respond_with(@transaction)
    end
  end

  private

  def set_account
    @account = Finances::Account.for_user(current_user).find(params[:account_id])
  end

  def set_transactions
    @transactions = @account.transactions
  end

  def set_transaction
    @transaction = @account.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:finances_transaction).permit(:finances_account_id, :description, :amount, :reconciled)
  end

end
