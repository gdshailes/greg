require 'test_helper'

class Finances::TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get finances_transactions_name:string_url
    assert_response :success
  end

  test "should get account_id:integer" do
    get finances_transactions_account_id:integer_url
    assert_response :success
  end

end
