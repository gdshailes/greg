module Finances::AccountsHelper

  def upcoming_bills(account)

    upcoming_bills = []
    bills = account.bills.to_a

    ((Date.current)..(Date.current + 2.months)).each do |date|

      bills.select{|a| a[:next_due_at] == date}.each do |bill|

        upcoming_bills << Finances::Transaction.new(amount: bill.amount, description: bill.description, reconciled: false, created_at: date)
        case bill.frequency
        when 'Months'
          bill.next_due_at = date + (bill.interval).months
        when 'Weeks'
          bill.next_due_at = date + (bill.interval).weeks
        when 'Days'
          bill.next_due_at = date + (bill.interval).days
        end

      end
    end
    upcoming_bills
  end
end
