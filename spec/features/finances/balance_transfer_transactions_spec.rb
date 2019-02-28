require 'rails_helper'

RSpec.feature 'Balance Transfer Transactions', type: :feature do

  let!(:user) { FactoryBot.create(:user) }
  let!(:source_account) { FactoryBot.create(:finances_account, user: user, primary: true) }
  let!(:destination_account) { FactoryBot.create(:finances_account, user: user) }

  context 'user creates balance transfer between current and credit-card account' do

    it 'works' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      visit "finances/accounts/#{source_account.id.to_s}/transactions/new"
      select destination_account.name, from: 'Pay Balance Of'
      click_button 'Save'
    end

  end

end