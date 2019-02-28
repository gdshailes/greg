class AddTypeToFinancesBills < ActiveRecord::Migration[5.0]
  def change
    add_column :finances_bills, :type, :string
  end
end
