class Finances::Transaction < ApplicationRecord

  belongs_to :account

  default_scope -> { order(transaction_date: :asc, amount_pence: :desc) }
  scope :for_account, -> (account_id) { where(account_id: account_id) }
  scope :unreconciled, -> { where.not(type: 'Finances::Transaction::Reconciled') }
  scope :reconciled, -> { where(type: 'Finances::Transaction::Reconciled') }
  scope :basic, -> { where(type: 'Finances::Transaction::Basic') }

  monetize :amount_pence, as: :amount

  validates :transaction_date, presence: :true
  validates :description, presence: true
  validates_numericality_of :amount

  attr_reader :bill_id

  def bill_id=(bill_id)
    @bill_id = bill_id.to_i
  end

  def reconciled
    reconciled?
  end

  def reconciled?
    false
  end

  comma do
    account 'Account' do |account|
      account.name.to_s
    end
    transaction_date 'Date'
    description 'Description'
    amount 'Amount'
  end

end
