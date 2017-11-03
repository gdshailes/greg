class Finances::AccountsController < Finances::BaseController

  include Finances::AccountsHelper

  def index
    if @accounts.primary.any?
      redirect_to finances_account_path(@accounts.primary.first)
    end
  end

  def show
    @upcoming_bills = upcoming_bills(@account)
    @balance = (@account.opening_balance || 0)
    @transactions = @account.transactions
    @include_reconciled = include_reconciled?
    unless @include_reconciled
      @balance += (@account.reconciled_balance || 0)
      @transactions = @transactions.unreconciled
    end
    respond_with(@account)
  end

  def new
    @account = Finances::Account.new(user: current_user, name: "New Account")
    @account.primary = @primary_account ? false : true
    respond_with(@account)
  end

  def edit
  end

  def create
    @account = Finances::Account.new(account_params)
    @account.user_id = current_user.id
    @account.reconciled_balance_pence = 0
    @account.save
    respond_with(@account)
  end

  def update
    # new_reconciled_balance = @account.reconciled_balance + (account_params[:opening_balance].to_money - @account.opening_balance)
    @account.update(account_params)
    respond_with(@account)
  end

  def destroy
    @account.destroy
    respond_with(@account)
  end

  private

    def include_reconciled?
      params[:full]
    end

    def account_params
      params.require(:finances_account).permit(:user_id, :name, :opening_balance, :reconciled_balance, :primary)
    end

end
