class Finances::CreateTransferForm
  include ActiveModel::Model

  attr_accessor :transfer_date, :description, :to_account_id, :amount, :reconciled

  def initialize(from_account)
    @transfer_date = Date.current
    @from_account = from_account
  end

  def submit(params)

    @transfer_date = params[:transfer_date].to_date
    @description = params[:description]
    @to_account = Finances::Account.find(params[:to_account_id])
    @amount = params[:amount].to_money
    @reconciled = (params[:reconciled] == "1")

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
          if @reconciled
            @from_account.reconciled_balance -= @amount
            @from_account.save!
          end
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
          if @reconciled
            @to_account.reconciled_balance += @amount
            @to_account.save!
          end
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