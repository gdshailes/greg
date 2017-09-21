class CreateFinancesAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :finances_accounts do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.monetize :opening_balance
      t.boolean :primary, null: false

      t.timestamps null: false
    end
  end
end
