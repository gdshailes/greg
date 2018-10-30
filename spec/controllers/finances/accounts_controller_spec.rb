require 'rails_helper'

RSpec.describe Finances::AccountsController, :type => :controller do
  describe 'POST update' do
    context 'update reconciled balance' do
      let(:account) { FactoryBot.create(:finances_account, opening_balance_pence: 15000, reconciled_balance_pence: 0) }
      it 'correctly updates the reconciled balance' do
        patch :update, params: { id: account.id, opening_balance: 100.00 }
      end
    end
  end
end