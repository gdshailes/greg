class Finances::CreateTransferForm
  include ActiveModel::Model

  attr_accessor :transfer_date, :description, :to_account_id, :amount, :reconciled

  def initialize(from_account)
    @transfer_date = Date.current
    @description = 'New Transfer'
    @from_account = from_account
  end

  def submit(params)

    @params = params

    @transfer_date = transfer_params[:transfer_date].to_date
    @description = transfer_params[:description]
    @to_account = Finances::Account.find(transfer_params[:to_account_id])
    @amount = transfer_params[:amount].to_money
    @reconciled = (transfer_params[:reconciled] == "1")

    if valid?
      create_from_transaction
      create_to_transaction
    end
    errors.blank?

  end

  def to_accounts
    Finances::Account.for_user(@from_account.user).where.not(id: @from_account.id).map do |account|
      [account.name, account.id]
    end
  end

  private

    def transfer_params
      @params.permit(:transfer_date, :description, :from_account_id, :to_account_id, :amount, :reconciled)
    end

    def valid?
      errors.add(:transfer_date, 'cannot be blank') if @transfer_date.nil?
      errors.add(:amount, 'must be positive') if @amount <= 0
      errors.add(:transfer_to, 'account must be selected') if @to_account.nil?
      errors.add(:description, 'cannot be blank') if @description.blank?
      errors.blank?
    end

    def create_from_transaction
      @from_account.transactions.build do |tx|
        tx.transaction_date = @transfer_date
        tx.amount = @amount * -1
        tx.description = @description
        tx.reconciled = @reconciled
        if tx.valid?
          tx.save!
        else
          promote_errors(tx.errors)
        end
      end
    end

    def create_to_transaction
      @to_account.transactions.build do |tx|
        tx.transaction_date = @transfer_date
        tx.amount = @amount
        tx.description = @description
        tx.reconciled = @reconciled
        if tx.valid?
          tx.save!
        else
          promote_errors(tx.errors)
        end
      end
    end

    def promote_errors(child_errors)
      child_errors.each do |attribute, message|
        errors.add(attribute, message)
      end
    end

end