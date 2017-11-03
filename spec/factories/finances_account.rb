FactoryGirl.define do

    factory :finances_account, class: "Finances::Account" do

      primary false
      opening_balance_pence Faker::Number
      reconciled_balance_pence Faker::Number
      created_at Time.current
      updated_at Time.current

    end

end