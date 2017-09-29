class Finances::Bill < ApplicationRecord

  belongs_to :account

  scope :for_account, -> (account_id) { where(account_id: account_id) }

  monetize :amount_pence, as: "amount"

  validates :next_due_at, presence: true
  validates :description, presence: true
  validates_numericality_of :amount


  def increment_next_due_at
    case frequency
    when 'Months'
      self.next_due_at += (interval).months
    when 'Weeks'
      self.next_due_at += (interval).weeks
    when 'Days'
      self.next_due_at += (interval).days
    end
  end

  def increment_next_due_at!
    increment_next_due_at
    save!
  end

  def create_payment_transaction
    tx = payment_transaction
    increment_next_due_at
    tx
  end

  def create_payment_transaction!
    tx = payment_transaction
    increment_next_due_at!
    tx
  end

  private

    def payment_transaction
      Finances::Transaction.new(
        account: account,
        description: description,
        amount_pence: amount_pence,
        reconciled: false,
        transaction_date: next_due_at,
      )
    end

end
