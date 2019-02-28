class Finances::Transaction < ApplicationRecord

  belongs_to :account

  default_scope -> { order(transaction_date: :asc, amount_pence: :desc) }
  scope :for_account, -> (account_id) { where(account_id: account_id) }
  scope :unreconciled, -> { where(reconciled: true) }

  monetize :amount_pence, as: :amount

  validates :transaction_date, presence: :true
  validates :description, presence: true
  validates_numericality_of :amount, unless: :is_balance_payment?
  validate :receiving_account_is_valid

  has_one :to_account, class_name: 'Finances::Account'

  attr_reader :bill_id

  def bill_id=(bill_id)
    @bill_id = bill_id.to_i
  end

  def amount
    return Money.new(amount_pence) unless is_balance_payment?
    Money.new(to_account.balance_pence)
  end

  comma do
    account 'Account' do |account|
      account.name.to_s
    end
    transaction_date 'Date'
    description 'Description'
    amount 'Amount'
  end


  private


  def is_balance_payment?
    to_account.present?
  end

  def receiving_account_is_valid
    errors.add(:to_account, 'cannot transfer to self') if to_account == self.account
  end

end
