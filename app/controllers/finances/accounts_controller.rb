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
    @include_reconciled = include_reconciled?
    transactions = @account.transactions
    incoming_transfers = @account.incoming_transfers
    unless @include_reconciled
      @balance += (@account.reconciled_balance || 0)
      transactions = transactions.unreconciled
      incoming_transfers = incoming_transfers.unreconciled
    end
    union = [transactions, incoming_transfers].map(&:to_sql).join(' UNION ALL ')
    transactions = Finances::Transaction.select("finances_transactions.*")
      .from("(#{union}) AS finances_transactions")
      .order("finances_transactions.transaction_date")
    @transaction_form = Finances::EditTransactionForm.new

    @transactions = transactions.all.to_a.map{|transaction| {bill_id: nil, date: transaction.transaction_date, transaction: transaction} } + @upcoming_bills
    @transactions.sort_by!{|tx|tx[:date]}

    respond_with(@account)
  end

  def new
    @account = Finances::Account.new(user: current_user)
    @account.primary = @primary_account ? false : true
    respond_with(@account)
  end

  def edit; end

  def create
    @account = Finances::Account.new(account_params)
    @account.user_id = current_user.id
    @account.reconciled_balance_pence = 0
    @account.save!
    respond_with(@account)
  end

  def update
    @account.update(account_params)
    respond_with(@account)
  end

  def destroy
    binding.pry
    if @account.destroy
      redirect_to finances_accounts_path
    end
  end


  private


  def include_reconciled?
    params[:full]
  end

  def account_params
    params.require(:finances_account).permit(:user_id, :name, :opening_balance, :reconciled_balance, :primary)
  end

end
