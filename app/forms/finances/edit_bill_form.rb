class Finances::EditBillForm
  include ActiveModel::Model

  attr_accessor :description, :amount, :frequency, :interval, :next_due_at

  delegate :description, :frequency, :interval, :next_due_at, to: :bill

  def initialize(bill)
    @bill = bill
  end

  def submit(params)
    @params = params
    @bill.update_attributes(bill_params)
    unless supporting_params[:deposit] == '1'
      @bill.amount = @bill.amount * -1
    end
    if @bill.valid?
      @bill.save!
    end
  end

  def bill
    @bill
  end

  def amount
    @bill.amount.abs
  end

  def deposit
    @bill.amount > 0 ? true : false
  end

  private

  def bill_params
    @params.permit(:description, :amount, :frequency, :interval, :next_due_at)
  end

  def supporting_params
    @params.permit(:deposit)
  end

end