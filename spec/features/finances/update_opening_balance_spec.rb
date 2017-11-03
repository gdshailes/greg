require 'rails_helper'

RSpec.describe Finances::AccountsController, :type => :controller do

  context 'test' do

    let(:account) { create(:finances_account, opening_balance_pence: 15000, reconciled_balance_pence: 0) }

    describe 'POST update' do

      it 'correctly updates the reconciled balance' do

        patch :update, params: { id: account.id, opening_balance: 100.00 }

        binding.pry

      end

    end

  end

end