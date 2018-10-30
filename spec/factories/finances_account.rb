FactoryBot.define do

    factory :finances_account, class: "Finances::Account" do
      association :user
      primary false
      opening_balance_pence Faker::Commerce.price
      reconciled_balance_pence Faker::Commerce.price
      created_at Time.current
      updated_at Time.current
    end

end