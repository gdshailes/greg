class Finances::Account < ApplicationRecord

  belongs_to :user
  has_many :transactions
  has_many :bills

  scope :for_user, -> (user_id) { where(user_id: user_id) }
  scope :primary, -> { where(primary: true) }

  monetize :opening_balance_pence, as: "opening_balance"
  monetize :reconciled_balance_pence, as: "reconciled_balance"
  monetize :balance_pence, as: "balance"

  def balance_pence
    transaction_sum = transactions.for_account(id).unreconciled.sum(:amount_pence)
    opening = (opening_balance_pence || 0)
    reconciled = (reconciled_balance_pence) || 0
    opening + reconciled + transaction_sum
  end

end
