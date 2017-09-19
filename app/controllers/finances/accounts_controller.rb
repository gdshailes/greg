class Finances::AccountsController < ActionController::Base

  before_action :set_finances_account, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @finances_accounts = Finances::Account.all
    respond_with(@finances_accounts)
  end

  def show
    respond_with(@finances_account)
  end

  def new
    @finances_account = Finances::Account.new
    respond_with(@finances_account)
  end

  def edit
  end

  def create
    @finances_account = Finances::Account.new(finances_account_params)
    @finances_account.save
    respond_with(@finances_account)
  end

  def update
    @finances_account.update(finances_account_params)
    respond_with(@finances_account)
  end

  def destroy
    @finances_account.destroy
    respond_with(@finances_account)
  end

  private
    def set_finances_account
      @finances_account = Finances::Account.find(params[:id])
    end

    def finances_account_params
      params.require(:finances_account).permit(:user_id, :name, :opening_balance)
    end
end
