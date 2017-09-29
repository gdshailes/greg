  class Finances::Transaction < ApplicationRecord

  belongs_to :account

  default_scope -> { order(transaction_date: :asc, amount_pence: :desc) }
  scope :for_account, -> (account_id) { where(account_id: account_id) }
  scope :unreconciled, -> { where(reconciled: false) }

  monetize :amount_pence, as: "amount"

  validates :transaction_date, presence: :true
  validates :description, presence: true
  validates_numericality_of :amount

end
