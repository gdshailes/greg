class Finances::AccountsController < Finances::BaseController

  include Finances::AccountsHelper

  def index
    if @accounts.primary.any?
      redirect_to finances_account_path(@accounts.primary.first)
    end
  end

  def show
    @transactions = @account.transactions
    @upcoming_bills = upcoming_bills(@account)
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
    @account.update(account_params)
    respond_with(@account)
  end

  def destroy
    @account.destroy
    respond_with(@account)
  end

  private

  def account_params
    params.require(:finances_account).permit(:user_id, :name, :opening_balance, :primary)
  end

end
