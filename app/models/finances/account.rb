class Finances::Account < ApplicationRecord

  belongs_to :user
  has_many :transactions, dependent: :destroy, class_name: '::Finances::Transaction'
  # has_many :basic_transactions, dependent: :destroy, class_name: '::Finances::Transaction::Basic'
  # has_many :reconciled_transactions, dependent: :destroy, class_name: '::Finances::Transaction::Reconciled'
  # has_many :transfer_transactions, dependent: :destroy, class_name: '::Finances::Transaction::Transfer'
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

end
