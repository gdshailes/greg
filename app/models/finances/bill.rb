class Finances::Bill < ApplicationRecord

  belongs_to :account

  scope :for_account, -> (account_id) { where(account_id: account_id) }

  monetize :amount_pence, as: "amount"

end
