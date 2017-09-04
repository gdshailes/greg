class AddAdministratorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :administrator, :boolean
  end
end
