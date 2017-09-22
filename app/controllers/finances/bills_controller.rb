class Finances::BillsController < Finances::BaseController

  before_action :set_bill, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @bills = @account.bills
    respond_with(@bills)
  end


  def new
    @bill = Finances::Bill.new(description: 'New Bill')
    respond_with(@bill)
  end

  def edit
  end

  def create
    @bill = Finances::Bill.new(bill_params)
    @bill.account_id = @account.id
    @bill.save
    redirect_to finances_account_bills_path(@account)
  end

  def update
    @bill.update(bill_params)
    redirect_to finances_account_bills_path(@account)
  end

  def destroy
    @bill.destroy
    redirect_to finances_account_bills_path(@account)
  end

  private
    def set_bill
      @bill = Finances::Bill.find(params[:id])
    end

    def bill_params
      params.require(:finances_bill).permit(:description, :amount, :frequency, :interval, :next_due_at)
    end
end
