class Finances::Transaction < ApplicationRecord

  belongs_to :account

  scope :for_account, -> (account_id) { where(account_id: account_id) }
  scope :unreconciled, -> { where(reconciled: false) }
  scope :incoming_transfers, -> (to_account) { where(to_account: to_account) }

  monetize :amount_pence, as: :amount, allow_nil: true

  validates :transaction_date, presence: :true
  validates :description, presence: true
  validates_numericality_of :amount, unless: :is_balance_payment?
  validate :receiving_account_is_valid

  belongs_to :to_account, optional: true, class_name: 'Finances::Account'

  attr_reader :bill_id

  def bill_id=(bill_id)
    @bill_id = bill_id.to_i
  end

  def to_account=(account_id)
    super(Finances::Account.find(account_id.to_s)) unless account_id.blank?
  end

  def amount_pence
    return super unless is_balance_payment?
    return to_account.balance_pence
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
    to_account.present? && self.reconciled == false
  end

  def receiving_account_is_valid
    errors.add(:to_account, 'cannot transfer to self') if to_account == self.account
  end

end
