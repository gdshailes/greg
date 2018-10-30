class Finances::TransfersController < Finances::BaseController

  before_action :set_account, :set_form, only: [:new, :create]
  attr_reader :create_transfer_form, :account

  respond_to :html

  def new; end

  def create
    if create_transfer_form.submit(transfer_params)
      redirect_to finances_account_path(account)
    else
      render 'finances/transfers/new'
    end

  end

  private

    def set_form
      @create_transfer_form = Finances::CreateTransferForm.new(@account)
    end

    def set_account
      @account = Finances::Account.find(params[:account_id])
    end

    def transfer_params
      params.require(:finances_create_transfer_form).permit(:transfer_date, :description, :from_account_id, :to_account_id, :amount, :reconciled)
    end

end