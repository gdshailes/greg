class Finances::Account < ApplicationRecord

  belongs_to :user
  has_many :transactions, dependent: :destroy
  has_many :bills, dependent: :destroy

  scope :for_user, -> (user) { where(user: user) }
  scope :primary, -> { where(primary: true) }

  monetize :opening_balance_pence, as: :opening_balance
  monetize :reconciled_balance_pence, as: :reconciled_balance
  monetize :balance_pence, as: :balance

  def balance_pence
    transaction_sum = transactions.for_account(id).unreconciled.sum(:amount_pence)
    opening = (opening_balance_pence || 0)
    reconciled = (reconciled_balance_pence) || 0
    opening + reconciled + transaction_sum
  end

  def other_accounts
    Finances::Account.for_user(self.user).where.not(id: self.id).map do |account|
      [account.name, account.id]
    end
  end

end
