class Finances::Transaction::Basic < Finances::Transaction
  def reconciled=(value)
    if value == '1'
      self.becomes!(Finances::Transaction::Reconciled)
    end
  end
end