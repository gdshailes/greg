class Finances::BaseController < ApplicationController

  before_action :authenticate_user!
  before_action :set_account
  before_action :set_accounts

  respond_to :html

  layout 'finances'


  private


  def set_accounts
    @accounts = Finances::Account.for_user(current_user).order(primary: :desc, name: :asc)
  end

  def set_account
    account_id = params[:account_id] || params[:id]
    @account = Finances::Account.find(account_id) if account_id
  end

end