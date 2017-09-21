class Finances::Transaction < ApplicationRecord

  belongs_to :account

  scope :for_account, -> (account_id) { where(account_id: account_id) }
  scope :unreconciled, -> { where(reconciled: false) }

  monetize :amount_pence, as: "amount"

end
