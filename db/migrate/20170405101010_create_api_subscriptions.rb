class CreateApiSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :api_subscriptions do |t|
      t.string :target_url
      t.string :event

      t.timestamps
    end
  end
end
