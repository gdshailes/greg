class Finances::BillsController < Finances::BaseController

  before_action :set_bill, only: [:edit, :update, :destroy, :record_payment]

  respond_to :html

  def index
    @bills = @account.bills.order(:description)
    respond_with(@bills)
  end

  def new
    @bill_form = Finances::EditBillForm.new(Finances::Bill.new(interval: 1, frequency: 'Months', next_due_at: Date.current))
  end

  def edit
    @bill_form = Finances::EditBillForm.new(@bill)
  end

  def create
    @bill_form = Finances::EditBillForm.new(@account.bills.build)
    if @bill_form.submit(bill_form_params)
      redirect_to finances_account_bills_path @account
    end
  end

  def update
    @bill_form = Finances::EditBillForm.new(@bill)
    if @bill_form.submit(bill_form_params)
      redirect_to finances_account_bills_path @account
    end
  end

  def destroy
    if @bill.destroy
      redirect_to finances_account_bills_path(@account)
    end
  end

  def record_payment
    @transaction_form = Finances::EditTransactionForm.new(@bill.create_payment_transaction)
    render :template => 'finances/transactions/new'
  end

  private
    def set_bill
      @bill = @account.bills.find(params[:bill_id] || params[:id])
    end

    def bill_form_params
      params.require(:finances_edit_bill_form).permit(:description, :deposit, :amount, :frequency, :interval, :next_due_at)
    end
end
