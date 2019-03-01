FactoryBot.define do

    factory :finances_account, class: 'Finances::Account' do
      association :user
      primary { false }
      name { Faker::Commerce.product_name }
      opening_balance_pence { Faker::Commerce.price }
      reconciled_balance_pence { Faker::Commerce.price }
      created_at { Time.current }
      updated_at { Time.current }

      trait :negative_balance do
        opening_balance_pence { Faker::Commerce.price * -1 }
        reconciled_balance_pence { Faker::Commerce.price * -1 }
      end

    end

end