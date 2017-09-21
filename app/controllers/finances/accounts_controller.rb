class Finances::AccountsController < ActionController::Base

  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :set_accounts

  respond_to :html

  def index
    if @accounts.primary.any?
      redirect_to finances_account_path(@accounts.primary.first)
    end
  end

  def show
    @transactions = @account.transactions
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

  def set_accounts
    @accounts = Finances::Account.for_user(current_user.id)
  end

  def set_account
    @account = Finances::Account.find(params[:id])
  end

  def account_params
    params.require(:finances_account).permit(:user_id, :name, :opening_balance, :primary)
  end

end
