require 'rails_helper'

RSpec.feature 'Balance Transfer Transactions', type: :feature do

  let!(:user) { FactoryBot.create(:user) }
  let!(:source_account) { FactoryBot.create(:finances_account, user: user, primary: true) }
  let!(:destination_account) { FactoryBot.create(:finances_account, :negative_balance, user: user) }

  context 'user creates balance transfer between current and credit-card account' do

    it 'works' do

      initial_source_balance = source_account.balance
      initial_destination_balance = destination_account.balance
      initial_destination_reconciled_balance = destination_account.reconciled_balance

      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      visit "finances/accounts/#{source_account.id.to_s}/transactions/new"
      select destination_account.name, from: 'Pay Balance Of'
      fill_in 'Description', with: 'Balance Payment'
      click_button 'Save'

      expect(Finances::Transaction.first.amount).to eq(initial_destination_balance)
      expect(source_account.reload.balance).to eq(initial_source_balance + initial_destination_balance)
      expect(destination_account.reload.balance).to eq(initial_destination_balance)

      click_link "#{source_account.name} *"
      click_link 'Balance Payment'
      check 'Reconciled'
      click_button 'Save'
      click_link destination_account.name

      expect(page).to have_text("#{destination_account.name} #{Money.new(0)}")

    end

  end

end
