module Finances::AccountsHelper

  def upcoming_bills(account)
    upcoming_bills = []
    if account.bills.any?
      bills = account.bills.order(:next_due_at).to_a
      start_from = bills.first.next_due_at
      ((start_from)..(Date.current + 2.months)).each do |date|
        bills.select{|a| a[:next_due_at] == date}.each do |bill|
          upcoming_bills << {bill_id: bill.id, date: date, transaction: bill.create_payment_transaction}
        end
      end
    end
    return upcoming_bills
  end

end
