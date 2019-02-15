require 'rails_helper'

describe Finances::CreateTransferForm do

  subject { Finances::CreateTransferForm.new(source_account) }

  describe '#submit' do

    let(:source_account) { FactoryBot.create(:finances_account) }
    let(:destination_account) { FactoryBot.create(:finances_account) }

    context 'successful reconciled transfer' do

      let(:params) do
        { transfer_date:    Date.current.to_s,
          description:      'transfer',
          from_account_id:  source_account.id.to_s,
          to_account_id:    destination_account.id.to_s,
          amount:           '0.50',
          reconciled:       '1' }
      end

      it 'creates a transaction in the source account and destination accounts' do
        expect { subject.submit(params) }.to change(Finances::Transaction, :count).by(2)

        expect(source_account.transactions.reconciled.count).to eq(1)

        source_account.transactions.reconciled.first.tap do |tx|
          expect(tx.amount_pence).to eq(-50)
          expect(tx.description).to eq('transfer')
          expect(tx.reconciled).to be(true)
        end

        expect(destination_account.transactions.reconciled.count).to eq(1)

        destination_account.transactions.reconciled.first.tap do |tx|
          expect(tx.amount_pence).to eq(50)
          expect(tx.description).to eq('transfer')
          expect(tx.reconciled).to be(true)
        end

      end

      it 'updates the reconciled totals on both accounts' do

        source_balance = source_account.reconciled_balance_pence
        destination_balance = destination_account.reconciled_balance_pence

        expect(subject.submit(params)).to be(true)

        expect(source_account.reload.reconciled_balance_pence).to eq(source_balance - 50)
        expect(destination_account.reload.reconciled_balance_pence).to eq(destination_balance + 50)

      end
    end

    context 'successful unreconciled transfer' do
      let(:params) { {
        transfer_date:    Date.current.to_s,
        description:      'transfer',
        from_account_id:  source_account.id.to_s,
        to_account_id:    destination_account.id.to_s,
        amount:           '1.94'
      } }

      it 'does not update the reconciled total on either account' do

        source_balance = source_account.reconciled_balance_pence
        destination_balance = destination_account.reconciled_balance_pence

        expect(subject.submit(params)).to be(true)

        source_account.reload
        destination_account.reload

        expect(source_account.reconciled_balance_pence).to eq(source_balance)
        expect(destination_account.reconciled_balance_pence).to eq(destination_balance)

      end
    end

  end

end