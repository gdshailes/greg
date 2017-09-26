  class Finances::Transaction < ApplicationRecord

  belongs_to :account

  scope :for_account, -> (account_id) { where(account_id: account_id).order(:transaction_date) }
  scope :unreconciled, -> { where(reconciled: false).order(:transaction_date) }

  monetize :amount_pence, as: "amount"

end
