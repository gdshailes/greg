module Finances::AccountsHelper

  def upcoming_bills(account)

    upcoming_bills = []
    bills = account.bills.to_a

    ((Date.current)..(Date.current + 2.months)).each do |date|

      bills.select{|a| a[:next_due_at] == date}.each do |bill|
        upcoming_bills << {bill_id: bill.id, transaction: bill.create_payment_transaction}
      end
    end
    upcoming_bills
  end
end
