class Finances::Account < ApplicationRecord

  belongs_to :user
  has_many :transactions

  scope :for_user, -> (user_id) { where(user_id: user_id) }
  scope :primary, -> { where(primary: true) }

  monetize :opening_balance_pence, as: "opening_balance"

  def balance
    3.14
  end

end
