class Finances::Transaction::Reconciled < Finances::Transaction

  def reconciled=(value)
    unless value == '1'
      self.becomes!(Finances::Transaction::Basic)
    end
  end

  def reconciled?
    true
  end

end